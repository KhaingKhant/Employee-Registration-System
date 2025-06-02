# Employee Registration System

A simple employee registration system built with InterSystems IRIS. This system manages employee information with support for Japanese character input validation.

> **Note**: `src/mac/EMP.mac` is the main program file. Other files in the repository are deprecated and maintained only for reference.

## Features

- Employee registration with validation
- Support for Kanji and Kana input
- Employee number management
- Address management

## Prerequisites

- InterSystems IRIS 2022.1
- VS Code with InterSystems ObjectScript Extension
- Git

## Setup

1. Clone the repository

```bash
git clone https://github.com/KhaingKhant/Employee-Registration-System.git
```

2. Create a new namespace 'BVI' in IRIS Management Portal

3. Import and run the program:
   - Open VS Code with InterSystems ObjectScript extension
   - Connect to your IRIS instance
   - Load and compile `src/mac/EMP.mac`
   - Run the program by executing:
     ```objectscript
     DO ^EMP
     ```

## Development

- Only modify `src/mac/EMP.mac` as it contains the complete, up-to-date implementation
- Other files (`*.cls` and other `*.mac` files) are deprecated
- Follow the included .gitignore for version control
- Test the program thoroughly before committing changes
