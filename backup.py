#!/usr/bin/env python3

import os
import subprocess
import tkinter as tk
from tkinter import filedialog, messagebox

# Set source directory
SRC_DIR = os.path.expanduser("~/.var/app")

class BackupApp:
    def __init__(self, master):
        self.master = master
        master.title("Flatpak Backup")

        self.src_label = tk.Label(master, text="Source directory:")
        self.src_label.pack(pady=10)

        self.src_entry = tk.Entry(master, state='readonly')
        self.src_entry.pack(pady=10)

        self.src_button = tk.Button(master, text="Browse", command=self.browse_src)
        self.src_button.pack(pady=10)

        self.dest_label = tk.Label(master, text="Destination directory:")
        self.dest_label.pack(pady=10)

        self.dest_entry = tk.Entry(master, state='readonly')
        self.dest_entry.pack(pady=10)

        self.dest_button = tk.Button(master, text="Browse", command=self.browse_dest)
        self.dest_button.pack(pady=10)

        self.backup_button = tk.Button(master, text="Backup", command=self.backup, fg="white", bg="green")
        self.backup_button.pack(pady=10)

    def browse_src(self):
        src_dir = filedialog.askdirectory(initialdir=SRC_DIR)
        if src_dir:
            self.src_entry.configure(state='normal')
            self.src_entry.delete(0, tk.END)
            self.src_entry.insert(0, src_dir)
            self.src_entry.configure(state='readonly')

    def browse_dest(self):
        dest_dir = filedialog.askdirectory()
        if dest_dir:
            self.dest_entry.configure(state='normal')
            self.dest_entry.delete(0, tk.END)
            self.dest_entry.insert(0, dest_dir)
            self.dest_entry.configure(state='readonly')

    def backup(self):
        src_dir = self.src_entry.get()
        dest_dir = self.dest_entry.get()

        if not src_dir:
            messagebox.showerror("Error", "Source directory is not specified")
            return

        if not dest_dir:
            messagebox.showerror("Error", "Destination directory is not specified")
            return

        backup_filename = os.path.join(dest_dir, f"flatpakbackup-{subprocess.check_output('date +%Y%m%d-%H%M%S', shell=True).decode().strip()}.tgz")

        try:
            subprocess.check_call(["tar", "--create", "--gzip", "--file", backup_filename, src_dir])
        except subprocess.CalledProcessError as e:
            messagebox.showerror("Error", f"Backup failed with error code {e.returncode}")
            return

        packages_filename = os.path.join(dest_dir, "packages.txt")

        try:
            with open(packages_filename, "w") as f:
                subprocess.check_call(["flatpak", "list", "--app", "--columns=ref"], stdout=f)
        except subprocess.CalledProcessError as e:
            messagebox.showwarning("Warning", "Could not save list of installed flatpaks")

        messagebox.showinfo("Info", "Backup complete")

if __name__ == '__main__':
    root = tk.Tk()
    app = BackupApp(root)
    root.mainloop()
