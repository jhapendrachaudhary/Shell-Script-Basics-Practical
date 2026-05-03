# Bash Special Parameters – Quick Reference

These variables are **automatically set** by the shell and are essential for writing robust scripts.

| Parameter | Meaning | Example |
|----------|--------|--------|
| `$0` | Name of the script or shell | `./myscript.sh` |
| `$1`, `$2`, … `$9` | First 9 positional arguments | `arg1="hello" → $1=hello` |
| `${10}`, `${11}`, … | Arguments 10+ (must use braces) | `${10}` |
| `"$#"` | **Number of arguments** passed | `./s.sh a b → $# = 2` |
| `"$*"` | All arguments as **one string** | `"a b c"` |
| `"$@"` | All arguments as **separate words** (preserves quoting) | `"a" "b" "c"` |
| `$$` | **Process ID (PID)** of the current shell | `12345` |
| `$!` | PID of the **last background job** | `sleep 30 & → $! = PID` |
| `$?` | **Exit status** of the last command (`0` = success) | `ls /fake; echo $? → 2` |
| `$_` | Last argument of the previous command | `ls /etc; echo $_ → /etc` |
| `$-` | Current **shell options** (e.g., `himBHs`) | `echo $- → himBHs` |

---

## Key Notes

### 🔄 `"$*"` vs `"$@"`
- Use `"$@"` in **99% of cases** — it preserves spaces and arguments correctly.
  ```bash
  for arg in "$@"; do echo "$arg"; done
