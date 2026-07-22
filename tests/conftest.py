import sys
from pathlib import Path

# Ajouter le répertoire parent au PYTHONPATH pour que pytest trouve app.py
sys.path.insert(0, str(Path(__file__).parent.parent))
