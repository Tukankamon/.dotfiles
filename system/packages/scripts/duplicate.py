#!/usr/bin/env python3
import sys
import re
from collections import defaultdict
import argparse

def parse_store_paths(file_path):
    packages = []
    if file_path is None:
        if sys.stdin.isatty():
            print("ERROR: No input detected")
            sys.exit(1)
        lines = [line.strip() for line in sys.stdin if line.strip()]
    else:
        with open(file_path, 'r') as f:
            lines = [line.strip() for line in f if line.strip()]

    for line in lines:
        path = line.split('/', 3)[-1]
        try:
            hash_part, rest = path.split('-', 1)
        except ValueError:
            continue

        # Split at first dash before a number (version)
        match = re.search(r'-(\d.*)$', rest)
        if match:
            version_start = match.start(1)
            name = rest[:version_start-1]
            version = rest[version_start:]
        else:
            name, version = rest, "unknown"

        # Detect variants
        if name.endswith("-unwrapped"):
            canonical_name = name[:-len("-unwrapped")]
            variant = "unwrapped"
        else:
            canonical_name = name
            variant = "main"

        packages.append((canonical_name, variant, version))
    return packages

def build_tree(packages):
    """
    Build hierarchical tree: canonical_name -> variant -> versions
    """
    tree = defaultdict(lambda: defaultdict(list))  # canonical -> variant -> versions
    for canonical_name, variant, version in packages:
        tree[canonical_name][variant].append(version)

    # Remove duplicate versions
    for pkg in tree:
        for var in tree[pkg]:
            tree[pkg][var] = sorted(set(tree[pkg][var]))

    return tree

def filter_tree(tree, n):
    """
    Remove packages/variants that appear <= n times
    """
    filtered = {}
    for pkg, variants in tree.items():
        total_count = sum(len(v) for v in variants.values())
        if total_count > n:
            filtered_variants = {var: vers for var, vers in variants.items() if len(vers) > n}
            filtered[pkg] = filtered_variants if filtered_variants else variants
    return filtered

def print_tree(tree, v):
    for pkg in sorted(tree):
        if v == 0:
            # Just count total occurrences (all variants)
            total_count = sum(len(vs) for vs in tree[pkg].values())
            print(f"{pkg} = {total_count}")
        else:
            # Full hierarchical tree
            main_versions = tree[pkg].get("main", [])
            variants = {k: v for k, v in tree[pkg].items() if k != "main"}

            total_versions = sum(len(vs) for vs in tree[pkg].values())
            print(f"{pkg} ({total_versions})")
            for i, vstr in enumerate(main_versions):
                prefix = "└── " if not variants and i == len(main_versions)-1 else "├── "
                print(f"{prefix}{vstr}")

            for idx, (var_name, var_versions) in enumerate(variants.items()):
                print(f"└── {var_name} ({len(var_versions)})")
                for j, vv in enumerate(var_versions):
                    prefix = "└── " if j == len(var_versions)-1 else "├── "
                    print(f"    {prefix}{vv}")

def main():
    parser = argparse.ArgumentParser(description="Analyze nix-store --query --requisites output")
    parser.add_argument("file", nargs="?", help="File or empty for stdin")
    parser.add_argument("-n", type=int, default=1, help="Minimum occurrences to display")
    parser.add_argument("-v", type=int, choices=[0,1], default=0, help="Verbose mode")
    args = parser.parse_args()

    packages = parse_store_paths(args.file)
    tree = build_tree(packages)
    tree = filter_tree(tree, args.n)
    print_tree(tree, args.v)

main()
