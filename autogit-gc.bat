cd . && for /d %%d in (*.*) DO (
	@echo ------------------------------------------ Processing: %%d
	cd "%%d" && git gc && cd ..
)