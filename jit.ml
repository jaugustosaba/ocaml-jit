external run_native : string -> int = "run_native"

let compile stack_instrs =
  let buffer = Buffer.create 100 in
  (* 
    push   %rbp
    mov    %rsp,%rbp
  *)
  let prologue = "\x55\x48\x89\xe5" in
  (*
    pop    %rbp
    retq   $0x0
  *)
  let epilogue = "\x58\x5d\xc2\x00\x00" in
  let compile_instr stack_instr =
    match stack_instr with
    | Stack.Push n ->
        (*
          movabs $0x...,%rax
          push   %rax
        *)
        begin
          Buffer.add_string buffer "\x48\xb8";
          for i=0 to 7 do
            let byte = char_of_int (0xff land (n lsr (8 * i))) in
              Buffer.add_char buffer byte
          done;
          Buffer.add_string buffer "\x50"
        end    
    | Stack.Add ->
        (*
          pop    %rax
          add    %rax,(%rsp)
        *)
        Buffer.add_string buffer "\x58\x48\x01\x04\x24"
    | Stack.Mul ->
        (*
          pop    %rax
          imul   (%rsp),%rax
          mov    %rax,(%rsp)
        *)
        Buffer.add_string buffer "\x58\x48\x0f\xaf\x04\x24\x48\x89\x04\x24"
  in begin
    Buffer.add_string buffer prologue;
    Array.iter compile_instr stack_instrs;
    Buffer.add_string buffer epilogue;
    Buffer.contents buffer
  end


let execute stack_instrs =
  let code = compile stack_instrs in
    run_native code

