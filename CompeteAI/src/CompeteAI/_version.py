from importlib.metadata import PackageNotFoundError, version

try:
    __version__ = version("CompeteAI")
except PackageNotFoundError:
    __version__ = "0.dev0"
