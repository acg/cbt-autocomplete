## A Browser Demo of Fast Autocomplete with CBT

Uses a [public dataset of Amazon queries](https://huggingface.co/datasets/amazon/AmazonQAC).

https://github.com/user-attachments/assets/48d65808-149f-4802-883e-ee25aef1b95f

### Requirements

- [`cbt`](https://github.com/SuperScript/cbt) for fast autocomplete.
- [`duckdb`](https://duckdb.org/docs/2.0/installation) for querying the dataset's parquet files.
- [`tcpserver`](https://cr.yp.to/ucspi-tcp.html) for serving the browser demo.
- `curl`
- `make`

### Running The Demo

```sh
make serve
```
