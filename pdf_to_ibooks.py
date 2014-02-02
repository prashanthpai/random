#!/bin/env python

# Script to generate plist file from directory containing PDFs
# This enables opening of PDFs on iBooks without need for iTunes
# Tested on iBooks 3.2 on iPad Air running iOS 7.0.4

from hashlib import md5
import plistlib
import os


def create_book_entry(filename):
    book = {
        'Inserted-By-iBooks': True,
        'Name': str(filename.split('.')[0]),
        'Package Hash': str(md5(filename).hexdigest().upper()),
        'Page Progression Direction': 'default',
        'Path': filename,
        's': 0,
        }
    return book

#List of all PDF files in current directory
files = [f for f in os.listdir('.') if os.path.isfile(f) and
         (f.endswith('.pdf') or f.endswith('.PDF'))]

books = []
for filename in files:
    book = create_book_entry(filename)
    books.append(book)

dict_root = {'Books': books}

# Create plist file named Purchases_New.plist in current directory.
plistlib.writePlist(dict_root, 'Purchases_New.plist')
