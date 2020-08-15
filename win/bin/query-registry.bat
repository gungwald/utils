@for /f "skip=1 tokens=3" %%d in ('reg query %1 /v %2') do @echo %%d
