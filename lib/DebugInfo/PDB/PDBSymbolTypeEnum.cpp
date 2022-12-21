//===- PDBSymbolTypeEnum.cpp - --------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/DebugInfo/PDB/PDBSymbolTypeEnum.h"

#include "llvm/DebugInfo/PDB/PDBSymDumper.h"
#include "llvm/DebugInfo/PDB/PDBSymbolTypeBuiltin.h"

#include <utility>

using namespace llvm;
using namespace llvm::pdb;

void PDBSymbolTypeEnum::dump(PDBSymDumper &Dumper) const { Dumper.dump(*this); }
