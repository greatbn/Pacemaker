resource webdata{
	disk /dev/sdb2;
	device /dev/drbd1;
	meta-disk internal;
	on ctl1 {
		address 10.10.10.11:7790;
	}
	on ctl2{
		address 10.10.10.12:7790;
	}
}