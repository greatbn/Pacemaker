resource mysql {
        disk /dev/sdb1;
        device /dev/drbd0;
        meta-disk internal;
        on ctl1 {
                address 10.10.10.11:7789;
        }
        on ctl2 {
                address 10.10.10.12:7789;
        }
}