# reviewdog-action-infer

This action checks the report of [Infer][] with [reviewdog][]

This action is not run [Infer][], You can install Infer on the runner with [setup-infer][]

## Examples

![examples image](https://user-images.githubusercontent.com/1439172/140608153-e80d0cc0-399e-4b66-aae8-49c468a831b4.png)

## Inputs

### `github_token`

Optional. `${{ github.token }}` is used by default.

### `report_path`

Optional. Infer report directory path.
Default is `./infer-out`.

### `tool_name`

Optional. Tool name to use for reviewdog reporter. Useful when running multiple
actions with different config.

### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`].
It's same as `-level` flag of reviewdog.

### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-pr-review`].
The default is `github-pr-check`.

### `filter_mode`

Optional. Filtering mode for the reviewdog command [`added`, `diff_context`, `file`, `nofilter`].
Default is `added`.

### `fail_on_error`

Optional.  Exit code for reviewdog when errors are found [`true`, `false`]
Default is `false`.

### `reviewdog_flags`

Optional. Additional reviewdog flags.

## Example usage

```yml
name: reviewdog
on: [pull_request]
jobs:
  infer:
    name: runner / infer
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v1
      - name: Setup Infer
        uses: srz-zumix/setup-infer@v1
      - name: Infer
        run: |
            infer -- make
      - name: Check Infer report
        uses: srz-zumix/reviewdog-action-infer@v1
        with:
          reporter: github-pr-review # Default is github-pr-check
```

## License

[MIT](https://choosealicense.com/licenses/mit)

[reviewdog]:https://github.com/reviewdog
[Infer]:https://github.com/facebook/infer
[setup-infer]:https://github.com/srz-zumix/setup-infer
