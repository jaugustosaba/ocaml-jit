#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <caml/mlvalues.h>


typedef int (*JitFun)(void);

CAMLprim value run_native(value code) {
	char *ptr = String_val(code);
	size_t n = caml_string_length(code);
	int result = 0;
	void *exec_mem = mmap(NULL, n, PROT_WRITE | PROT_READ | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
	if (exec_mem != MAP_FAILED) {
		memcpy(exec_mem, ptr, n);
		JitFun fun = (JitFun) exec_mem;
		result = fun();
		if (munmap(exec_mem, n) == -1) {
			perror("run_native fatal error");
			exit(EXIT_FAILURE);
		}
	}
	return Val_int(result);
}