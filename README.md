## Laravel Development Environment

### Requirements

You use this you need:
- docker-compose
- mkcert (after installation run `mkcert -install` to install local CA)
- bash or zsh (optional, for autocomplete work)

### Preparing to work

First, clone this repository to directory ~/workspace/feedback

```bash
git clone https://github.com/artem-slastyon/TenoriumFeedbackDocker.git ~/workspace/feedback
```

Then enter new directory and run setup script:
```bash
cd ~/workspace/feedback
./scripts/main.sh setup
```
Then restart shell

### Starting containers

> ⚠️
> Before start make sure that you have these ports free: 80, 443, 3306 and 8080

To manage containers you can use `feedback` command followed by subcommand.

For example to start container you can run this command:
```bash
feedback up
```

Below you can find full list of commands.

### Subcommands

#### General commands

| Name   | Description                                       |
|--------|---------------------------------------------------|
| docker | Docker-related functions (build image, exec bash) |
| setup  | Setup or update environment                       |
| mkcert | Launch mkcert with custom args                    |


#### Vite commands

| Name  | Description   |
|-------|---------------|
| build | Build project |
| watch | Watch project |

#### PHP commands

| Name     | Description              |
|----------|--------------------------|
| artisan  | Execute artisan command  |
| composer | Execute composer command |

#### Git commands

| Name  | Description                            |
|-------|----------------------------------------|
| clone | Clone repositories that not cloned yet |
| git   | Run git command for each repository    |

#### Power commands

| Name    | Description        |
|---------|--------------------|
| up      | Start containers   |
| down    | Stop containers    |
| restart | Restart containers |

#### Docker commands

Docker commands like `feedback docker build`

| Name  | Usage           | Description                          |
|-------|-----------------|--------------------------------------|
| build | build           | Build docker images                  |
| exec  | exec \<service> | Execute bash in selected service     |
| temp  | temp            | Run temporary ubuntu:22.04 container |
| watch | watch           | Watch build context                  |
