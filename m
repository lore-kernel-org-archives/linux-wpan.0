Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58197 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932333AbdJRMGU (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Oct 2017 08:06:20 -0400
From: Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: [RFC 3/3] tun: Add 6LoWPAN compression/decompression to tun driver
Date: Wed, 18 Oct 2017 15:06:15 +0300
Message-Id: <20171018120615.24126-4-patrik.flykt@linux.intel.com>
In-Reply-To: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
References: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: luiz.von.dentz@intel.com

Define a new IFF_6LO flag for the tun/tap driver that enables 6LoWPAN
compression/decompression for tap devices. This is achieved by calling
lowpan_header_compress once the sk_buff is destined for user space and
calling lowpan_header_decompress when the user space writes packets to
kernel. A copy of the ethernet MAC headers are needed both ways, as
the 6LoWPAN compression may end up expanding the header size by one
byte in the worst case.

LOWPAN_IPHC_MAX_HC_BUF_LEN more bytes are added to sk_buff headroom
to ensure there will be enough bytes to push headers to. This is
probably an overkill and probably done wrongly anyway.

An ethernet MAC header is added in front of the (compressed) IPv6
datagram in both directions; no such transport exists for 6LoWPAN,
but this is just an example implementation trying to explain the
idea behind the BTLE handling in user space and the 6LoWPAN
compression and decompression in kernel space. Thus the tun/tap
driver comes in handy as the victim of the demonstration.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 drivers/net/tun.c           | 61 +++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/if_tun.h |  1 +
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 3c9985f29950..8770ad46d3ef 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -66,6 +66,7 @@
 #include <linux/nsproxy.h>
 #include <linux/virtio_net.h>
 #include <linux/rcupdate.h>
+#include <net/6lowpan.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/rtnetlink.h>
@@ -227,6 +228,8 @@ struct tun_struct {
 	u32 rx_batched;
 	struct tun_pcpu_stats __percpu *pcpu_stats;
 	struct bpf_prog __rcu *xdp_prog;
+
+	struct lowpan_dev       ldev;
 };
 
 #ifdef CONFIG_TUN_VNET_CROSS_LE
@@ -975,6 +978,9 @@ static void tun_set_headroom(struct net_device *dev, int new_hr)
 		new_hr = NET_SKB_PAD;
 
 	tun->align = new_hr;
+
+	if ((tun->flags & (IFF_TAP|IFF_6LO)) == (IFF_TAP|IFF_6LO))
+		tun->align += LOWPAN_IPHC_MAX_HC_BUF_LEN;
 }
 
 static void
@@ -1515,6 +1521,27 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb->dev = tun->dev;
 		break;
 	case IFF_TAP:
+		if (tun->flags & IFF_6LO) {
+			struct ethhdr eth;
+
+			skb_reset_mac_header(skb);
+			memcpy(&eth, skb_mac_header(skb), sizeof(eth));
+
+			skb_pull(skb, sizeof(struct ethhdr));
+			skb_reset_network_header(skb);
+
+			if (lowpan_header_decompress(skb, &tun->ldev,
+							tun->dev->dev_addr,
+							&eth.h_source) < 0) {
+				this_cpu_inc(tun->pcpu_stats->rx_dropped);
+				kfree_skb(skb);
+				return -EINVAL;
+			}
+
+			memcpy(skb_push(skb, sizeof(eth)), &eth, sizeof(eth));
+			skb_reset_mac_header(skb);
+		}
+
 		skb->protocol = eth_type_trans(skb, tun->dev);
 		break;
 	}
@@ -1596,6 +1623,25 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	int vlan_hlen = 0;
 	int vnet_hdr_sz = 0;
 
+	if ((tun->flags & (IFF_6LO | IFF_TAP)) == (IFF_6LO | IFF_TAP) &&
+			skb->protocol == htons(ETH_P_IPV6)) {
+		struct ethhdr eth;
+		int err;
+
+		memcpy(&eth, skb_mac_header(skb), sizeof(eth));
+
+		skb_pull(skb, sizeof(struct ethhdr));
+		skb_reset_network_header(skb);
+
+		err = lowpan_header_compress(skb, &tun->ldev, &eth.h_dest,
+					tun->dev->dev_addr);
+		if (err < 0)
+			return -EINVAL;
+
+		memcpy(skb_push(skb, sizeof(eth)), &eth, sizeof(eth));
+		skb_reset_mac_header(skb);
+	}
+
 	if (skb_vlan_tag_present(skb))
 		vlan_hlen = VLAN_HLEN;
 
@@ -1904,7 +1950,8 @@ static struct proto tun_proto = {
 
 static int tun_flags(struct tun_struct *tun)
 {
-	return tun->flags & (TUN_FEATURES | IFF_PERSIST | IFF_TUN | IFF_TAP);
+	return tun->flags & (TUN_FEATURES | IFF_PERSIST | IFF_TUN | IFF_TAP |
+		IFF_6LO);
 }
 
 static ssize_t tun_show_flags(struct device *dev, struct device_attribute *attr,
@@ -1974,6 +2021,9 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
+		if (ifr->ifr_flags & IFF_6LO && !(ifr->ifr_flags & IFF_TAP))
+			return -EINVAL;
+
 		if (tun_not_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
@@ -2013,9 +2063,14 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 			/* TAP device */
 			flags |= IFF_TAP;
 			name = "tap%d";
+			if (ifr->ifr_flags & IFF_6LO)
+				flags |= IFF_6LO;
 		} else
 			return -EINVAL;
 
+		if (ifr->ifr_flags & IFF_6LO && !(ifr->ifr_flags & IFF_TAP))
+			return -EINVAL;
+
 		if (*ifr->ifr_name)
 			name = ifr->ifr_name;
 
@@ -2054,6 +2109,8 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		if (err < 0)
 			goto err_free_stat;
 
+		lowpan_initialize_ctx(&tun->ldev, LOWPAN_LLTYPE_BTLE);
+
 		tun_net_init(dev);
 		tun_flow_init(tun);
 
@@ -2257,7 +2314,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		 * This is needed because we never checked for invalid flags on
 		 * TUNSETIFF.
 		 */
-		return put_user(IFF_TUN | IFF_TAP | TUN_FEATURES,
+		return put_user(IFF_TUN | IFF_TAP | IFF_6LO | TUN_FEATURES,
 				(unsigned int __user*)argp);
 	} else if (cmd == TUNSETQUEUE)
 		return tun_set_queue(file, &ifr);
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 3cb5e1d85ddd..6e515c606754 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -60,6 +60,7 @@
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
 #define IFF_TAP		0x0002
+#define IFF_6LO         0x0010
 #define IFF_NO_PI	0x1000
 /* This flag has no real effect */
 #define IFF_ONE_QUEUE	0x2000
-- 
2.11.0

