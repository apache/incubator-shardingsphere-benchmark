PROXY_HOST=10.12.3.160

sysbench oltp_read_only --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=10 --time=120 --threads=32 --max-requests=0 --percentile=99 --mysql-ignore-errors="all" --rand-type=uniform --range_selects=off --auto_inc=off cleanup

sysbench oltp_read_only --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=10 --time=360 --threads=32 --max-requests=0 --percentile=99 --mysql-ignore-errors="all" --rand-type=uniform --range_selects=off --auto_inc=off prepare


sysbench oltp_read_only        --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run

sysbench oltp_read_only        --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_read_only.master.txt

sysbench oltp_point_select     --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_point_select.master.txt

sysbench oltp_read_write        --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_readwrite.master.txt

sysbench oltp_write_only       --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_write_only.master.txt

sysbench oltp_update_index     --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_update_index.master.txt

sysbench oltp_update_non_index --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_update_non_index.master.txt

sysbench oltp_delete           --mysql-host=${PROXY_HOST} --mysql-port=3307 --mysql-user=root --mysql-password='root' --mysql-db=sbtest --tables=10 --table-size=100000 --report-interval=30  --time=180 --threads=32 --max-requests=0 --percentile=99  --mysql-ignore-errors="all" --range_selects=off --rand-type=uniform --auto_inc=off run | tee oltp_delete.master.txt