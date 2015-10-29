#Pacemaker
[1. Cluster là gì](https://github.com/greatbn/Pacemaker#1-cluster-là-gì)

[2. Mô hình triển khai](https://github.com/greatbn/Pacemaker#2-mô-hình-triển-khai)

- [2.1 High Performance Cluster(HPC)](https://github.com/greatbn/Pacemaker#21-high-performance-clusterhpc)
	
- [2.2 Load Balancing Cluster (LBC)](https://github.com/greatbn/Pacemaker#22-load-balancing-cluster-lbc)
	
- [2.3 High Availabality Cluster (HAC)](https://github.com/greatbn/Pacemaker#23-high-availabality-cluster-hac)
	
[3. Lịch sử của HAC trong Linux](https://github.com/greatbn/Pacemaker#3-lịch-sử-của-hac-trong-linux)

[4. Các thành phần trong HAC](https://github.com/greatbn/Pacemaker#4-các-thành-phần-trong-hac)

[5. Kiến trúc Pacemaker](https://github.com/greatbn/Pacemaker#5-kiến-trúc-pacemaker)

- [5.1 Cluster Information Base (CIB)](https://github.com/greatbn/Pacemaker#51-cluster-information-base-cib)
	
- [5.2 CRMD](https://github.com/greatbn/Pacemaker#52crmd)
	
- [5.3 PEngine.](https://github.com/greatbn/Pacemaker#53-pengine)
	
- [5.4 LRMD ](https://github.com/greatbn/Pacemaker#54-lrmd)
	
- [5.5 STONITH](https://github.com/greatbn/Pacemaker#55-stonithfenced)
	
[6. Vấn dề xảy ra trong Cluster](https://github.com/greatbn/Pacemaker#6-vấn-dề-xảy-ra-trong-cluster)

[7.Cài đặt](https://github.com/greatbn/Pacemaker#7cài-đặt)

[8. Cấu hình](https://github.com/greatbn/Pacemaker#8-cấu-hình)

##1. Cluster là gì

- Cluster là một kiến trúc nhằm đảm bảo nâng cao khả năng sẵn sàng cho các hệ thống mạng máy tính

- Clustering cho phép sử dụng nhiều máy chủ kết hợp với nhau tạo thành một cụm có khả năng chịu đựng hay chấp nhận sai sót (fault-tolerant) nhằm nâng cao độ sẵn sàng của hệ thống mạng

##2. Mô hình triển khai

<ul>

<li>High Performance Cluster

</li>

<li>High Performance Cluster

</li>

<li>High Availability Cluster

</li>

</ul>

###2.1 High Performance Cluster(HPC)

- Nhiều máy tính khác nhau làm việc cùng nhau để cùng xử lí một hoặc nhiều tác vụ yêu cầu nhiều tài nguyên tính toán

- Mô hình tổng quan HPC

<img src="http://i.imgur.com/Ni0jI40.png">

###2.2 Load Balancing Cluster (LBC)

- Mỗi máy tính trong cluster sẽ xử lý 1 công việc riêng biệt

- Cần có Load Balancer (frontend ) và Server Farm (Backend)

- Mô hình tổng quan LBC

<img src="http://i.imgur.com/ncAePKn.png">

###2.3 High Availabality Cluster (HAC)

- Mục đích của kiểu cluster này là đảm bảo các tài nguyên quan trọng sẵn sàng tối đa có thể đạt được 

- Mô hình tổng quan HAC

<img src="http://i.imgur.com/jaIHALt.png">

##3. Lịch sử của HAC trong Linux

- HA có một lịch sử dài nó bắt đầu vào thập niên 90 của thế kỉ trước và nó là một giải pháp đơn giản với tên Heartbeat.

- Một Heartbeat cluster đơn giản chỉ làm 2 việc: 
	
	- Monitor 2 nodes và không hơn 2 node
	
	- Nó được cấu hình để start 1 hoặc nhiều dịch vụ trên 2 node

- Nếu resource trên node này bị down nó sẽ start resource trên node còn lại 

##4. Các thành phần trong HAC

- Các thành phần sau đây được sử dụng trong hầu hết clusters.

	- Shared Storage
	
	- Different networks
	
	- Bonded network devices
	
	- Multipathing
	
	- Fencing/ STONITH devices

- Mô hình kiến trúc HA Cluster

<img src="http://i.imgur.com/N0xAZUw.png">

- Resource agents:  
     - Pacemaker là một phần của cluster, có trách nhiệm quản lý các tài nguyên. 
	 - Để quản lý tài nguyên, Resource agent được sử dụng. 
	 - Một resource agent là một script mà cluster sử dụng để start, stop và monitor resource. Nó có thể so sánh với systemctl hoặc 1 script chạy có mức độ. Nhưng nó được điều chỉnh để sử dụng trong cluster. Nó cũng định nghĩa các thuộc tính có thể quản lý bởi cluster. Đối với 1 admin, Nó rất quan trọng để biết được thuộc tính nào có thể sử dụng trước khi bắt đầu cấu hình resources. 
	
- Corosync:  
     - Corosync là một layer có nhiệm vụ quản lý các node thành viên.
     - Nó cũng được cấu hình để giao tiếp với pacemaker.
     - Pacemaker nhận update về những sự thay đổi trạng thái của các node trong cluster. Dựa vào đó nó có thể bắt đầu một sự kiện nào đó ví dụ như migrate resource
	
- Storage layer:  
	 - Pacemaker cũng được sử dụng để quản lý các thiết bị lưu trữ.
     - Một quản lý khóa phân phối (Distribute Lock Manage DLM) cần phải có. DLM quản lý việc đồng bộ hóa các khóa giữa các nodes.
     - Nó đặc biệt quan trọng nếu là share storage như là cLVM2 cluster logical volume hoặc GFS2 và OCFS2 cluster file system.
	
##5. Kiến trúc Pacemaker

<img src="http://i.imgur.com/jEH1NZx.png">

###5.1 Cluster Information Base (CIB)

-  Trái tim của cluster là Cluster Information Base (CIB). Đây là trạng thái thực tế trong bộ nhớ của cluster đó là liên tục đông bộ giữa các node trong cluster. Đó là một điều rất quan trọng để một admin cần phải biết, Bạn sẽ không bao giờ chỉnh sửa trực tiếp được CIB. 

- Các CIB sử dụng XML để đại diện cho cả hai cấu hình của cluster và trạng thái hiện tại của tất cả các resource trong cluster. Nội dung của CIB được tự động giữ đồng bộ trên toàn bộ cụm.

-  Để hiểu làm thế nào cluster management tool làm viêc, hiểu biết việc CIB tổ chức như nào rất tốt. Sử dụng lệnh
cibadmin -Q

- Ví dụ về một CIB

```sh

root@ctl1:/home/saphi# cibadmin -Q
<cib epoch="500" num_updates="8" admin_epoch="0" validate-with="pacemaker-1.2" crm_feature_set="3.0.7" cib-last-written="Thu Oct 22 16:03:02 2015" update-origin="ctl2" update-client="cibadmin" have-quorum="0" dc-uuid="1">
  <configuration>
    <crm_config>
      <cluster_property_set id="cib-bootstrap-options">
        <nvpair id="cib-bootstrap-options-stonith-enabled" name="stonith-enabled" value="false"/>
        <nvpair id="cib-bootstrap-options-dc-version" name="dc-version" value="1.1.10-42f2063"/>
        <nvpair id="cib-bootstrap-options-no-quorum-policy" name="no-quorum-policy" value="ignore"/>
        <nvpair id="cib-bootstrap-options-cluster-infrastructure" name="cluster-infrastructure" value="corosync"/>
      </cluster_property_set>
    </crm_config>
    <nodes>
      <node id="2" uname="ctl2">
        <instance_attributes id="nodes-2">
          <nvpair id="nodes-2-standby" name="standby" value="off"/>
        </instance_attributes>
      </node>
      <node id="1" uname="ctl1">
        <instance_attributes id="nodes-1">
          <nvpair id="nodes-1-standby" name="standby" value="off"/>
        </instance_attributes>
      </node>
    </nodes>
    <resources>
      <master id="ms_drbd_1">
        <meta_attributes id="ms_drbd_1-meta_attributes">
          <nvpair id="ms_drbd_1-meta_attributes-clone-max" name="clone-max" value="2"/>
          <nvpair id="ms_drbd_1-meta_attributes-notify" name="notify" value="true"/>
          <nvpair id="ms_drbd_1-meta_attributes-interleave" name="interleave" value="true"/>
        </meta_attributes>
        <primitive id="res_drbd_1" class="ocf" provider="linbit" type="drbd">
          <instance_attributes id="res_drbd_1-instance_attributes">
            <nvpair id="nvpair-res_drbd_1-drbd_resource" name="drbd_resource" value="drbd0"/>
          </instance_attributes>
          <operations id="res_drbd_1-operations">
            <op interval="0" id="op-res_drbd_1-start" name="start" timeout="240"/>
            <op interval="0" id="op-res_drbd_1-promote" name="promote" timeout="90"/>
            <op interval="0" id="op-res_drbd_1-demote" name="demote" timeout="90"/>
            <op interval="0" id="op-res_drbd_1-stop" name="stop" timeout="100"/>
            <op id="op-res_drbd_1-monitor" name="monitor" interval="10" timeout="20" start-delay="0"/>
            <op interval="0" id="op-res_drbd_1-notify" name="notify" timeout="90"/>
          </operations>
          <meta_attributes id="res_drbd_1-meta_attributes"/>
        </primitive>
      </master>
      <primitive id="res_Filesystem_1" class="ocf" provider="heartbeat" type="Filesystem">
        <instance_attributes id="res_Filesystem_1-instance_attributes">
          <nvpair id="nvpair-res_Filesystem_1-device" name="device" value="/dev/drbd/by-res/drbd0/0"/>
          <nvpair id="nvpair-res_Filesystem_1-directory" name="directory" value="/mnt/sdb"/>
          <nvpair id="nvpair-res_Filesystem_1-fstype" name="fstype" value="ext4"/>
        </instance_attributes>
        <operations id="res_Filesystem_1-operations">
          <op interval="0" id="op-res_Filesystem_1-start" name="start" timeout="60"/>
          <op interval="0" id="op-res_Filesystem_1-stop" name="stop" timeout="60"/>
          <op id="op-res_Filesystem_1-monitor" name="monitor" interval="20" timeout="40" start-delay="0"/>
          <op interval="0" id="op-res_Filesystem_1-notify" name="notify" timeout="60"/>
        </operations>
        <meta_attributes id="res_Filesystem_1-meta_attributes"/>
      </primitive>
      <primitive id="res_IPaddr2_1" class="ocf" provider="heartbeat" type="IPaddr2">
        <instance_attributes id="res_IPaddr2_1-instance_attributes">
          <nvpair id="nvpair-res_IPaddr2_1-ip" name="ip" value="10.10.10.30"/>
          <nvpair id="nvpair-res_IPaddr2_1-cidr_netmask" name="cidr_netmask" value="255.255.255.0"/>
        </instance_attributes>
        <operations id="res_IPaddr2_1-operations">
          <op interval="0" id="op-res_IPaddr2_1-start" name="start" timeout="20"/>
          <op interval="0" id="op-res_IPaddr2_1-stop" name="stop" timeout="20"/>
          <op id="op-res_IPaddr2_1-monitor" name="monitor" interval="10" timeout="20" start-delay="0"/>
        </operations>
        <meta_attributes id="res_IPaddr2_1-meta_attributes"/>
      </primitive>
      <primitive id="res_apache2_1" class="service" type="apache2">
        <operations id="res_apache2_1-operations">
          <op interval="0" id="op-res_apache2_1-start" name="start" timeout="15"/>
          <op interval="0" id="op-res_apache2_1-stop" name="stop" timeout="15"/>
          <op id="op-res_apache2_1-monitor" name="monitor" interval="15" timeout="15" start-delay="15"/>
        </operations>
        <meta_attributes id="res_apache2_1-meta_attributes">
          <nvpair id="res_apache2_1-meta_attributes-target-role" name="target-role" value="Started"/>
        </meta_attributes>
      </primitive>
    </resources>
    <constraints>
      <rsc_colocation id="col_res_Filesystem_1_ms_drbd_1" score="INFINITY" with-rsc-role="Master" rsc="res_Filesystem_1" with-rsc="ms_drbd_1"/>
      <rsc_order id="ord_ms_drbd_1_res_Filesystem_1" score="INFINITY" first-action="promote" then-action="start" first="ms_drbd_1" then="res_Filesystem_1"/>
      <rsc_colocation id="col_res_IPaddr2_1_res_Filesystem_1" score="INFINITY" rsc="res_IPaddr2_1" with-rsc="res_Filesystem_1"/>
      <rsc_order id="ord_res_Filesystem_1_res_IPaddr2_1" score="INFINITY" first="res_Filesystem_1" then="res_IPaddr2_1"/>
      <rsc_colocation id="col_res_apache2_1_res_IPaddr2_1" score="INFINITY" rsc="res_apache2_1" with-rsc="res_IPaddr2_1"/>
      <rsc_order id="ord_res_IPaddr2_1_res_apache2_1" score="INFINITY" first="res_IPaddr2_1" then="res_apache2_1"/>
      <rsc_colocation id="col_res_haproxy_1_res_IPaddr2_1" score="INFINITY" rsc="res_haproxy_1" with-rsc="res_IPaddr2_1"/>
    </constraints>
    <rsc_defaults>
      <meta_attributes id="rsc-options"/>
    </rsc_defaults>
  </configuration>
  <status>
    <node_state id="1" uname="ctl1" in_ccm="true" crmd="online" crm-debug-origin="post_cache_update" join="member" expected="member">
      <transient_attributes id="1">
        <instance_attributes id="status-1">
          <nvpair id="status-1-probe_complete" name="probe_complete" value="true"/>
          <nvpair id="status-1-last-failure-res_Filesystem_1" name="last-failure-res_Filesystem_1" value="1445501248"/>
          <nvpair id="status-1-master-res_drbd_1" name="master-res_drbd_1" value="10000"/>
        </instance_attributes>
      </transient_attributes>
      <lrm id="1">
        <lrm_resources>
          <lrm_resource id="res_IPaddr2_1" type="IPaddr2" class="ocf" provider="heartbeat">
            <lrm_rsc_op id="res_IPaddr2_1_last_0" operation_key="res_IPaddr2_1_start_0" operation="start" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="42:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;42:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="405" rc-code="0" op-status="0" interval="0" last-run="1445503900" last-rc-change="1445503900" exec-time="441" queue-time="0" op-digest="3be16c7e9769d7f21aafee17a66f0e8a"/>
            <lrm_rsc_op id="res_IPaddr2_1_monitor_10000" operation_key="res_IPaddr2_1_monitor_10000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="43:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;43:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="409" rc-code="0" op-status="0" interval="10000" last-rc-change="1445503900" exec-time="240" queue-time="0" op-digest="46c93acded8a0a6f3a36d547b188ddba"/>
          </lrm_resource>
          <lrm_resource id="res_Filesystem_1" type="Filesystem" class="ocf" provider="heartbeat">
            <lrm_rsc_op id="res_Filesystem_1_last_0" operation_key="res_Filesystem_1_start_0" operation="start" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="39:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;39:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="400" rc-code="0" op-status="0" interval="0" last-run="1445503899" last-rc-change="1445503899" exec-time="187" queue-time="2" op-digest="3a91faf06fce460465231f770779a9bc"/>
            <lrm_rsc_op id="res_Filesystem_1_monitor_20000" operation_key="res_Filesystem_1_monitor_20000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="40:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;40:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="403" rc-code="0" op-status="0" interval="20000" last-rc-change="1445503900" exec-time="165" queue-time="0" op-digest="ac2217b1b44386b997b91f42441910bd"/>
          </lrm_resource>
          <lrm_resource id="res_drbd_1" type="drbd" class="ocf" provider="linbit">
            <lrm_rsc_op id="res_drbd_1_last_0" operation_key="res_drbd_1_promote_0" operation="promote" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="9:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;9:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="394" rc-code="0" op-status="0" interval="0" last-run="1445503899" last-rc-change="1445503899" exec-time="100" queue-time="0" op-digest="1243523f1dae58b4aafa2650a7f3d441"/>
            <lrm_rsc_op id="res_drbd_1_last_failure_0" operation_key="res_drbd_1_monitor_0" operation="monitor" crm-debug-origin="build_active_RAs" crm_feature_set="3.0.7" transition-key="4:33:7:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:8;4:33:7:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="132" rc-code="8" op-status="0" interval="0" last-run="1445501760" last-rc-change="1445501760" exec-time="511" queue-time="0" op-digest="1243523f1dae58b4aafa2650a7f3d441"/>
          </lrm_resource>
          <lrm_resource id="res_apache2_1" type="apache2" class="service">
            <lrm_rsc_op id="res_apache2_1_last_0" operation_key="res_apache2_1_start_0" operation="start" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="43:91:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;43:91:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="429" rc-code="0" op-status="0" interval="0" last-run="1445504582" last-rc-change="1445504582" exec-time="1197" queue-time="0" op-digest="f2317cad3d54cec5d7d7aa7d0bf35cf8"/>
            <lrm_rsc_op id="res_apache2_1_last_failure_0" operation_key="res_apache2_1_monitor_0" operation="monitor" crm-debug-origin="build_active_RAs" crm_feature_set="3.0.7" transition-key="7:69:7:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;7:69:7:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="283" rc-code="0" op-status="0" interval="0" last-run="1445502090" last-rc-change="1445502090" exec-time="42" queue-time="0" op-digest="f2317cad3d54cec5d7d7aa7d0bf35cf8"/>
            <lrm_rsc_op id="res_apache2_1_monitor_15000" operation_key="res_apache2_1_monitor_15000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="44:91:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;44:91:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="432" rc-code="0" op-status="0" interval="15000" last-rc-change="1445504598" exec-time="5" queue-time="15001" op-digest="02a5bcf940fc8d3239701acb11438d6a"/>
          </lrm_resource>
        </lrm_resources>
      </lrm>
    </node_state>
    <node_state id="2" uname="ctl2" in_ccm="false" crmd="offline" crm-debug-origin="post_cache_update" join="down" expected="member">
      <lrm id="2">
        <lrm_resources>
          <lrm_resource id="res_apache2_1" type="apache2" class="service">
            <lrm_rsc_op id="res_apache2_1_last_0" operation_key="res_apache2_1_stop_0" operation="stop" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="47:87:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;47:87:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="75" rc-code="0" op-status="0" interval="0" last-run="1445503884" last-rc-change="1445503884" exec-time="14254" queue-time="0" op-digest="f2317cad3d54cec5d7d7aa7d0bf35cf8"/>
            <lrm_rsc_op id="res_apache2_1_monitor_15000" operation_key="res_apache2_1_monitor_15000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="45:86:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;45:86:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="66" rc-code="0" op-status="0" interval="15000" last-rc-change="1445503881" exec-time="5" queue-time="15003" op-digest="02a5bcf940fc8d3239701acb11438d6a"/>
          </lrm_resource>
          <lrm_resource id="res_IPaddr2_1" type="IPaddr2" class="ocf" provider="heartbeat">
            <lrm_rsc_op id="res_IPaddr2_1_last_0" operation_key="res_IPaddr2_1_stop_0" operation="stop" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="41:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;41:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="88" rc-code="0" op-status="0" interval="0" last-run="1445503898" last-rc-change="1445503898" exec-time="94" queue-time="0" op-digest="3be16c7e9769d7f21aafee17a66f0e8a"/>
            <lrm_rsc_op id="res_IPaddr2_1_monitor_10000" operation_key="res_IPaddr2_1_monitor_10000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="43:86:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;43:86:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="59" rc-code="0" op-status="0" interval="10000" last-rc-change="1445503866" exec-time="398" queue-time="0" op-digest="46c93acded8a0a6f3a36d547b188ddba"/>
          </lrm_resource>
          <lrm_resource id="res_Filesystem_1" type="Filesystem" class="ocf" provider="heartbeat">
            <lrm_rsc_op id="res_Filesystem_1_last_0" operation_key="res_Filesystem_1_stop_0" operation="stop" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="38:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;38:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="96" rc-code="0" op-status="0" interval="0" last-run="1445503898" last-rc-change="1445503898" exec-time="91" queue-time="0" op-digest="3a91faf06fce460465231f770779a9bc"/>
            <lrm_rsc_op id="res_Filesystem_1_monitor_20000" operation_key="res_Filesystem_1_monitor_20000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="40:86:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;40:86:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="53" rc-code="0" op-status="0" interval="20000" last-rc-change="1445503865" exec-time="171" queue-time="0" op-digest="ac2217b1b44386b997b91f42441910bd"/>
          </lrm_resource>
          <lrm_resource id="res_drbd_1" type="drbd" class="ocf" provider="linbit">
            <lrm_rsc_op id="res_drbd_1_last_failure_0" operation_key="res_drbd_1_monitor_0" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="8:77:7:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;8:77:7:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="6" rc-code="0" op-status="0" interval="0" last-run="1445502486" last-rc-change="1445502486" exec-time="222" queue-time="0" op-digest="1243523f1dae58b4aafa2650a7f3d441"/>
            <lrm_rsc_op id="res_drbd_1_last_0" operation_key="res_drbd_1_demote_0" operation="demote" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="11:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;11:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="100" rc-code="0" op-status="0" interval="0" last-run="1445503898" last-rc-change="1445503898" exec-time="74" queue-time="0" op-digest="1243523f1dae58b4aafa2650a7f3d441"/>
            <lrm_rsc_op id="res_drbd_1_monitor_10000" operation_key="res_drbd_1_monitor_10000" operation="monitor" crm-debug-origin="do_update_resource" crm_feature_set="3.0.7" transition-key="13:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" transition-magic="0:0;13:88:0:11ef9dcd-c5f1-4bd1-a368-3d1b1ccc0f17" call-id="112" rc-code="0" op-status="0" interval="10000" last-rc-change="1445503899" exec-time="107" queue-time="0" op-digest="aaa74df15509b944df11eed5ad6096f0"/>
          </lrm_resource>
        </lrm_resources>
      </lrm>
      <transient_attributes id="2">
        <instance_attributes id="status-2">
          <nvpair id="status-2-master-res_drbd_1" name="master-res_drbd_1" value="10000"/>
          <nvpair id="status-2-probe_complete" name="probe_complete" value="true"/>
        </instance_attributes>
      </transient_attributes>
    </node_state>
  </status>
</cib>


```

- Thông tin được chia làm  2 phần là configuration và status.

     - Trong mục configuration sẽ có 3 phần chính khác nữa
	 
          - crm_config
		  
          - node: Hiển thị các node
		  
          - resouces: Các resource đc định nghĩa để cluster quản lý.
- Có các kiểu của resources sau

     - Primitives: Một Primitive là dịch vụ được quản lý bởi cluster. Nó là một instance đơn của service. 
	 
     - Groups: Một group là một tập hợp các primitives. Sự tiện lợi của group là cluster sẽ bắt đầu primitives mà là một phần của group. Nếu 1 primitive trong group bị fail, không có primitive nào trong group có thể start.
	 
     - Clones: Một clone là một primitive mà cần thiết để bắt đầu cluster hơn 1 lần. Clones hữu dụng cho các services mà phải là chế độ active/active  như file system cluster.
	 
     - Master slaves: Một master slave là một kiểu đặc biệt của clone. Trong đó 1 vài thể hiện (ít nhất là 1) active và những thể hiện khác là slave

###5.2.CRMD

- cluster resource management daemon là một tiến trình quản lý trạng thái hoạt động của cluster.

- Nhiệm vụ chính của crmd là chuyển tiếp trực tiếp các thông tin giữa nhiều components của cluster. Như việc đặt resource trên các node đặc biệt. Nó cũng có trách nhiện quản lý node transition. Node là master crmd thực sự hoạt động được công nhận là designated coordinator (DC). Nếu DC fail, cluster sẽ tự động chọn một DC mới rất nhanh chóng. 

###5.3. PEngine.

- Là một phần của cluster nó tính toán để đạt được. 

- Nó tạo ra một danh sách các hướng dẫn được gửi tới crmd. Cách tốt nhất để 1 admin tác động tới hành vi của pengine là đinh nghĩa những hạn chế trong cluster.

###5.4 LRMD 

- Local resource management daemon là một phần của cluster được chạy trên mỗi node của cluster.
 
- Nếu crmd quyết định chạy resource trên node đặc biệt nào, nó sẽ hướng dẫn lrmd vào nút đó để bắt đầu resource.

- Trong trường hợp nó không hoạt động lrmd sẽ trở về crmd và thông báo rằng start resource fail. Sau đó Cluster có thể cố gắng thử lại resource trên nút khác trong cluster.

- LRM cũng có trách nhiệm monitor operation và stop operation mà đang chạy trên node.

###5.5. Stonith/fenced 

- Viết tắt của Shoot the other node in the head

- Tiến trình stonith nhận hướng dẫn từ crmd về các thay đổi trạng thái của các node. 

- Nếu 1 node không trả lời, membership layer (corosync) sẽ nói cho crmd biết và crmd hướng dẫn stonith chấm dứt node đó. 

##6. Vấn dề xảy ra trong Cluster

###Split Brain

- Split brain có nghĩa là cluster bị chia ra làm 2 hoặc nhiều phần nhưng tất cả các phần nghĩ rằng chúng là những phần còn lại của cluster. 

- Điều này có thể dẫn tới 1 vấn đề xấu khi mà tất cả các phần của cluster cố gắng host các tài nguyên được đề nghị bởi cluster. 

- Nếu tài nguyên là file system và multi nodes cố gắng ghi file system đồng thời và không có sự phối hợp. Nó có thể dẫn tới corruption của file system và mất dữ liệu.  

Để giải quyết split brain người ta sử dụng quorum hoặc fencing/stonith

- Quá trình đàm phán Quorum 
	Quá trình đàm phán quorum xảy ra khi một node đang sở hữu một quorum resource bị lỗi hay không hoạt động, và các node còn lại sẽ xác định node nào sẽ giữ quyền sở hữu quorum resource. Mục đích của quá trình đàm phán quorum là tại một thời điểm đảm bảo rằng chỉ một node duy nhất được sở hữu quorum resource.
Việc chỉ cho một node sở hữu quorum resource là rất quan trọng bởi vì nếu tất cả các giao tiếp giữa 2 hay nhiều node bị lỗi, nó có khả năng chia Cluster thành 2 hay nhiều phần riêng biệt để giữ cho nó vần tiếp tục hoạt động (split brain). Server Cluster ngăn ngừa nó bằng cách chỉ cho phép duy nhất một Cluster tách ra này có chứa node đang sở hữu quorum resource tiếp tục hoạt động như một Cluster. Bất kỳ node nào không thể giao tiếp với node đang sở hữu quorum resource, thì node đó sẽ không còn là node thành viên trong Cluster.
- Stonith
    Đã nói bên trên

##7.Cài đặt

- Có thể thấy pacemaker chỉ là 1 thành phần để quản lý các resource nên khi cài đặt chúng ta phải cài đặt cùng với các thành phần khác để nó có thể hoạt động được 

- Trên ubuntu chạy lệnh sau, sau khi update

`sudo apt-get install pacemaker corosync crmsh cluster-glue resource-agents - y`

- Trên centos chạy lệnh sau

`sudo yum install pacemaker cman pcs ccs resource-agents -y `

##8. Cấu hình

- Chuẩn bị 2 Server có cấu hình tương đương:

-  OS: Ubuntu Server 14.04

-  CPU 1 core

-  RAM: 1GB
 
-  HDD 1: 20GB

- HDD 2: 5GB


- Mục này mình sẽ hướng dẫn xây dựng 1 cluster chạy web apache có thư mục source code và Database được đồng bộ giữa 2 node với nhau sử dụng DRBD 

- Trên 2 node sẽ cắm thêm 1 ổ cứng để thực hiện đồng bộ các file

- Mô hình 


<img src="http://i.imgur.com/l2dYp5J.png">


- Mình thực hiện trên **Ubuntu Server 14.04** khi chạy centos các lệnh có thể sẽ khác các bạn tìm hiểu thêm

- Sửa file hosts của cả 2 node

```

cat << EOF > /etc/hosts 
127.0.0.1       localhost
10.10.10.11     ctl1
10.10.10.12     ctl2
EOF

```
###Cài đặt các package cần thiết , chạy lần lượt các lệnh sau trên cả 2 node

```

apt-get update
apt-get install drbd8-utils -y
apt-get install pacemaker crmsh corosync cluster-glue resource-agents apache2 mariadb -y

```

- Để khởi động corosync và pacemaker cùng hệ thống chạy 2 lệnh sau trên cả 2 node

```

update-rc.d pacemaker defaults
update-rc.d corosync defaults

```

- Mặc định corosync không được chạy do vậy ta cần chỉnh sửa file defaults của nó trên cả 2 node

`sed -i "s/START=no/START=yes/g" /etc/default/corosync`

- Cấu hình corosync trên cả 2 node

Sửa file /etc/corosync/corosync.conf

Dòng  42:  bindnetaddr: điền dải mạng của 2 node sử dụng ví dụ của mình là 10.10.10.0

- Khởi động corosync và pacemaker trên cả 2 node

```

service corosync start
service pacemaker start

```

- Kiểm tra trạng thái Chạy lệnh `crm status` hoặc `crm_mon` trên 1 node

* lệnh `crm_mon` khác với lệnh `crm status` ở chỗ nó có thể cập nhật trạng thái liên tục nếu có sự thay đổi*

Khi cấu hình thành công sẽ như sau

<img src="http://i.imgur.com/uyXsT20.png">


###Cấu hình DRBD ( Distributed Replicated Block Device) trên cả 2 node
Enable module DRBD trên cả 2 node

`modprobe drbd`

Kiểm tra module đã được bật chưa

`lsmod | grep drbd`

Trước hết bạn cần phải có thêm 1 ổ cứng hoặc 2 phân vùng trống


Mình sẽ tạo 2 phân vùng mới trên 1 ổ cứng mình lắp thêm thực hiện trên cả 2 node

Chạy lệnh sau 

`echo -e "o\nn\np\n\n\n+2000MB\nn\np\n2\n\n\n\nw" | fdisk /dev/sdb`

Tạo resource cho DRBD ở đây mình tạo resource là mysql và webdata

Tạo file mysql.res và webdata.res tại /etc/drbd.d/với nội dung sau trên cả 2 node

- mysql.res

```

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


```

-webdata.res

```
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

```

Format định dạng cho 2 ổ thực hiện trên cả 2 node

```
mkfs.ext4 /dev/drbd0
mkfs.ext4 /dev/drbd1
```

Chạy lệnh sau trên cả 2 node để start resource DRBD

```
drbdadm create-md mysql
drbdadm up mysql
drbdadm create-md webdata
drbdadm up webdata
```

Lúc này dùng lệnh `cat /proc/drbd` thì cả 2 node sẽ là Secondary để 1 node là Primary thì trên node đó ta chạy lệnh sau

```
drbdadm primary --force mysql
drbdadm primary --force webdata
```


Trên cả 2 node sửa file /etc/mysql/my.cnf thay đổi datadir thành /mnt/database

Sửa tiếp file /etc/apparmor.d/usr.sbin.mysqld từ  `/var/lib/mysql` thành `/mnt/database`

Mount ổ mysql lên /mnt/database trên node primary node còn lại cũng tương tự nhưng phải đổi lại primary thành node đó rồi mount

`mount /dev/drbd0 /mnt/databae`

Copy dữ liệu mysql gốc sang mục này chỉ cần thực hiện trên 1 node

`cp -r /var/lib/mysql /mnt/database`

Set quyền cho mysql

```
chown mysql:mysql /mnt/database
chown -R mysql:mysql /mnt/database/*
```
Restart lại appamor và mysql trên cả 2 node

```
service apparmor reload
service mysql restart
```

Trên 1 node thực hiện tạo các resource Virtual IP, apache, mysql và File System



`crm configure property no-quorum-policy="ignore" stonith-enabled="false"`

ignore quorum và tắt stonith do mô hình của mình chỉ có 2 node. từ 3 node trở lên mới cần quorum hoặc STONITH để giải quyết split brain

`crm configure primitive p_IP ocf:heartbeat:IPaddr2 params ip="10.10.10.30" cidr_netmask="24" nic="eth0" op monitor interval="30s"`

Tạo Virtual IP có địa chỉ 10.10.10.30/24 nằm trên card eth0

`crm configure primitive p_apache ocf:heartbeat:apache params configfile="/etc/apache2/apache2.conf" port="80" op monitor interval="30s" op start interval="0s" timeout="40s" op stop interval="0s" timeout="40s"``

Tạo resource apache để pacemaker manage apache

`crm configure primitive p_drbd_mysql ocf:linbit:drbd params drbd_resource="mysql" op monitor interval="3s"`

Tạo resource DRBD cho MySQL

`crm configure primitive p_drbd_data ocf:linbit:drbd params drbd_resource="webdata" op monitor interval="3s"`

Tạo resource DRBD cho Dữ liệu web (source code)

`crm configure primitive p_fs_data ocf:heartbeat:Filesystem params device="/dev/drbd1" directory="/mnt/web" fstype="ext4" op start interval="0s" timeout="40s" op stop interval="0s" timeout="40s" op monitor interval="3s"`

Mount webdata tại /mnt/web. Khi cấu hình apache thì trỏ document root về thư mục này 

`crm configure primitive p_fs_mysql ocf:heartbeat:Filesystem params device="/dev/drbd0" directory="/mnt/database" fstype="ext4" op start interval="0s" timeout="40s" op stop interval="0s" timeout="40s" op monitor interval="3s"`

Mount dữ liệu Mysql về thư mục /mnt/database 

`crm configure primitive p_mysql ocf:heartbeat:mysql params additional_parameters="--bind-address=10.10.10.30" config="/etc/mysql/my.cnf" pid="/var/run/mysqld/mysqld.pid" socket="/var/run/mysqld/mysqld.sock" log="/var/log/mysql/mysqld.log" datadir="/mnt/database/"op monitor interval="20s" timeout="10s" op start timeout="120s" op stop timeout="120s"`

Tạo resource mysql để pacemaker quản lý

`crm configure ms ms_drbd_mysql p_drbd_mysql meta master-max="1"  master-node-max="1" clone-max="2" clone-node-max="1" notify="true"`

Tạo Master/Slave DRBD MySQL

`crm configure ms ms_drbd_data p_drbd_data meta master-max="1"  master-node-max="1" clone-max="2" clone-node-max="1" notify="true"`

Tạo Master/Slave DRBD Webdata

`crm configure colocation fs-on-drbd inf: p_fs_data ms_drbd_data:Master`

`crm configure colocation mysqldb-on-drbd inf: p_fs_mysql ms_drbd_mysql:Master`

Mount DRBD trên Master

`crm configure group FS p_fs_data p_fs_mysql`

Group 2 FS để start trên cùng 1 node

`crm configure IP-with-FS inf: p_IP FS`

Đặt địa chỉ IP trên node start group FS

`crm configure colocation apache-with-IP inf: p_apache p_IP`

apache start trên node đặt địa chỉ IP

`crm configure colocation mysql-with-IP inf: p_mysql p_IP`

MySQL-Server Start trên node đặt địa chỉ IP

`crm configure order fs-after-drbd inf: ms_drbd_data:promote p_fs_data:start`

Mount sau khi start DRBD webdata

`crm configure order mysql-after-drbd inf: ms_drbd_mysql:promote p_fs_mysql:start`

Mount sau khi start DRBD MySQL


Để dữ liệu được đồng bộ giữa 2 node đầy đủ thì ta cần cấu hình cho các resource không được di chuyển sang node khác khi node đó được phục hồi

`crm configure rsc_defaults resource-stickiness=100`

###Sau khi xong reboot lại máy kiểm tra crm_mon sẽ được kết quả như này

<img src="http://i.imgur.com/D2qo8EC.png">

Test thử power off node 2 thì resource sẽ start trên node 1

<img src="http://i.imgur.com/ILOrgXp.png">


- - -

#Tổng Kết

Bài viết trên mình đã giới thiệu tổng quan về Pacemaker và cách cấu hình nó. Để cấu hình 1 cluster không phải là dễ, nó rất khó bởi vì chỉ cần cấu hình 1 resource không đúng hoặc thứ tự start không đúng thì cluster sẽ không thể chạy theo đúng yêu cầu đặt ra được. Do vậy bài viết có gì sai xót mong các bạn góp ý

**Người viết: Sa Phi**

*Email: saphi070@gmail.com*





















	
	


