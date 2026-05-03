#!/usr/bin/env python3
import platform
import time
import datetime
import os
import sys

def get_uptime():
    """Calculate system uptime in a human-readable format."""
    try:
        # Try to get uptime from system files (Linux/macOS)
        with open('/proc/uptime', 'r') as f:
            uptime_seconds = float(f.readline().split()[0])
    except (FileNotFoundError, OSError, ValueError):
        # Fallback for other systems (Windows/macOS)
        boot_time = None
        if sys.platform == "win32":
            try:
                import ctypes
                from ctypes import wintypes
                kernel3_get_tick = ctypes.windll.kernel32.GetTickCount64
                kernel3_get_tick.restype = ctypes.c_uint64
                uptime_seconds = kernel3_get_tick() / 1000.0
            except (AttributeError, OSError):
                # Last resort: estimate from boot time (less accurate)
                boot_time = psutil.boot_time() if 'psutil' in sys.modules else None
                if boot_time is None:
                    return "Unknown"
                uptime_seconds = time.time() - boot_time
        elif sys.platform == "darwin":  # macOS
            try:
                # Use sysctl command for macOS
                import subprocess
                result = subprocess.run(['sysctl', '-n', 'kern.boottime'], 
                                      capture_output=True, text=True)
                if result.returncode == 0:
                    # Parse "sec = 1678886400, usec = 123456" format
                    boot_sec = int(result.stdout.split()[2].rstrip(','))
                    uptime_seconds = time.time() - boot_sec
                else:
                    raise OSError("sysctl failed")
            except (OSError, ValueError, IndexError):
                # Fallback using psutil if available
                boot_time = psutil.boot_time() if 'psutil' in sys.modules else None
                if boot_time is None:
                    return "Unknown"
                uptime_seconds = time.time() - boot_time
        else:
            # Generic fallback using psutil
            boot_time = psutil.boot_time() if 'psutil' in sys.modules else None
            if boot_time is None:
                return "Unknown"
            uptime_seconds = time.time() - boot_time

    # Convert seconds to human-readable format
    days = int(uptime_seconds // 86400)
    hours = int((uptime_seconds % 86400) // 3600)
    minutes = int((uptime_seconds % 3600) // 60)
    
    parts = []
    if days:
        parts.append(f"{days} day{'s' if days > 1 else ''}")
    if hours:
        parts.append(f"{hours} hour{'s' if hours > 1 else ''}")
    if minutes:
        parts.append(f"{minutes} minute{'s' if minutes > 1 else ''}")
    
    return ", ".join(parts) if parts else "Less than a minute"

def main():
    # Get OS information
    system = platform.system()
    release = platform.release()
    version = platform.version()
    
    # Get kernel information
    if system == "Linux":
        kernel = platform.release()  # Linux uses release as kernel version
    elif system == "Darwin":
        kernel = f"Darwin {platform.release()}"  # macOS kernel name
    elif system == "Windows":
        kernel = f"Windows NT {platform.version()}"
    else:
        kernel = "Unknown"
    
    # Get uptime
    uptime = get_uptime()
    
    # Display information
    print("System Information")
    print("==================")
    print(f"OS:       {system} {release}")
    print(f"Kernel:   {kernel}")
    print(f"Uptime:   {uptime}")

if __name__ == "__main__":
    main()
