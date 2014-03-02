ocaml-jit
=========

Simple Just-in-time (JIT) for arithmetic expressions done in Ocaml.

## System Requirements
* x86_64 
* Ubuntu >= 12.12 / OS X >= 10.6
* gcc >= 4.8
* gdb >= 7.61
* ocaml >= 3.12.1

## Files

Main files description.

### lexer.mll

Lexer (ocamllex)

### parser.mly

Parser (ocamlyacc)

### ast.ml

Abstract Syntax Tree

### interp.ml

Interpreter code.

### jit.ml

Just-in-time (JIT) code.

### main.ml

Compiler's main file.

### jit-x86_64.c

Takes executable memory from OS to execute code generated from ocaml code.

## Compiling

    $ ocamlbuild main.native

or for debug:

    $ ocamlbuild -tag debug main.native
    
to clean compiled code:

    $ ocamlbuild -clean

## Sample

    1+(2+3)*4

## Intermediate Representation

    0: push 1
    1: push 2
    2: push 3
    3: add
    4: push 4
    5: mul
    6: add

## Native code (dump from GDB)

    0x00007ffff7ff7000:	push   %rbp
    0x00007ffff7ff7001:	mov    %rsp,%rbp
    0x00007ffff7ff7004:	movabs $0x1,%rax
    0x00007ffff7ff700e:	push   %rax
    0x00007ffff7ff700f:	movabs $0x2,%rax
    0x00007ffff7ff7019:	push   %rax
    0x00007ffff7ff701a:	movabs $0x3,%rax
    0x00007ffff7ff7024:	push   %rax
    0x00007ffff7ff7025:	pop    %rax
    0x00007ffff7ff7026:	add    %rax,(%rsp)
    0x00007ffff7ff702a:	movabs $0x4,%rax
    0x00007ffff7ff7034:	push   %rax
    0x00007ffff7ff7035:	pop    %rax
    0x00007ffff7ff7036:	imul   (%rsp),%rax
    0x00007ffff7ff703b:	mov    %rax,(%rsp)
    0x00007ffff7ff703f:	pop    %rax
    0x00007ffff7ff7040:	add    %rax,(%rsp)
    0x00007ffff7ff7044:	pop    %rax
    0x00007ffff7ff7045:	pop    %rbp
    0x00007ffff7ff7046:	retq   $0x0

