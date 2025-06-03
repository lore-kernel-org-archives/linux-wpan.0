Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35331A3178;
	Tue,  3 Jun 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977521; cv=none; b=gRVolS4Y5/M5v3BZuJyFZy4KiIMbzXvrZY2HBe570YP9OoYLNpGXmfXgRQRHEh3UeMhCwRbnsXH8ENLb/CWPf7w5z+zubicRFTHciEr45r1YKE8uC/R+TMlBppZ9QI/ZLeOzK5DOESPE8uwSPuqr2Ukk2pmw1LfeQ55aVk8enq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977521; c=relaxed/simple;
	bh=Rog6ZjLXwMWO/dqz9ZduHnpzwX6+YqITZ/bx6R/hbY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFLTgBoRcxdysyvYUODHXkWXoIz2YKGGuaiBJI3XQlkdbVYerBliz5UgcXTyPS5WKIC4zrzHLEhpYVCqyKB7Vva06t0DX4csjaU89zKbX/wvft8m8q+f0otfsi00hOtzIskmvkPFxqwSAkPl7pGkBnpOrKZ0DpykKWSIq9vWhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWvE4JpQ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWvE4JpQ"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e59012c7eeso3952615137.1;
        Tue, 03 Jun 2025 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748977518; x=1749582318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnNAQHhdVox2ZajRiJviDlqOB3nlaUUYq92IlGzdpAE=;
        b=OWvE4JpQazEKwpypdd2GO9X8CeyhYPV14b7+Krxl1Ki2q9hz8BSg4knuCCqS+r4Y+j
         p3xVSCyMgBpbIKMT/+dYrquUw1TvKpFnOLSqEUtXwQb3dwucRxn1Xzcjhj94pkv1eHet
         lsJf7gJpQ2tAcZ2g+T5eIYs+2zz/WvNIUvBEUAq0eHp+/jGuE1nd5U9pfyIgdJQQghSY
         3SsMM/1bHpEIduYvceovFbe0dmDjOQFWJ726eEMnm+DPTNoxTO76g2uMIEWuhwjsQ3fF
         Zpn7LhQoKkJKfCSDhEvVFq9+H36oc0Ee9NfWNwnAbS4MlLDRnJ/L8vdAhu6WIfMe3Hju
         SRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748977518; x=1749582318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnNAQHhdVox2ZajRiJviDlqOB3nlaUUYq92IlGzdpAE=;
        b=vzDZg66TzNVFGNgrDwfXMhSN4tpvfItprpcmXB2m6IHRLadgb20JhOi1wOmBd/rFzX
         wwzdIlgmUHgzLPnXeOCfugp1lxqTOiEUFtig9g/3X73iCehNSdf+jK/g+juPreXKLpYs
         Dw7JEEMthLcjdMtS803nqc75nsVUPjrLGV97tz4hI/C8w2NOJKsB9zTV6HJifkUQDld7
         0w4w8VQtz3Q5z1vQ+ptlZi9xZLfpijorUvJHdVMFTN8VL4GBOEfhUfTItjYsy9nZyFI2
         71DSzGCD9p3qMXZEcBu+jWlOF/rHT9tFh+PGURMzQFCY2Dk9z5opFeW4Pz+T7Wh7VAPL
         TPeA==
X-Forwarded-Encrypted: i=1; AJvYcCXVOMQqrWr5g9XmdLrzbhtV4iPPkX6ndSQSsLU1iGutKjdgwso7/0THaaSy+tdPPRZ6beyZ3Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEThuk/94yAIPNRlQeS/v8JPBlbGcO9yIiqwJxPXuIMgUloOc
	ryHUwmJG+t8yGQ8DPNvGYa3Dv51Wbpvke/QYQtTw3gjHi8B2+51h+LKW
X-Gm-Gg: ASbGncsRZG9Omjc1VAtsrSZdVekTzORJBoBdCrXXuU0wRrsIyu86MWslb1MXdz3n0gT
	lSJunjEbPuM4hyMB3L4JPyfN4jbDnHcp5gYz8JoSHvGfVx8uhyKPcPJOeiuEHgpAUH75HCFQ3ch
	odQUCsQldFWJuz7wMxyujfoTfyw3bwv1YP3c2ZuS2NqrtJgha+PfgdaTWaN1mTWljZQxTpncU53
	+ULhhoj7tfSz9uefo3eSE3X+E8zYxlychVgeM4+QyNmyTVi9g6snTQVShpXIiWIn/jf1ZwD/PcS
	c1T7oC95LTPbuwFLFdMJpuBO8mELtis4xRTjtE9mwi+0xYp+6bGomiUe1IWnRzSnKdtzTpOtV6V
	fAuE+ManZd98=
X-Google-Smtp-Source: AGHT+IEn+gmkIK5mj+1N2AMmOLSCYpkOiysjFp+g9oOe5n4dKMALYCpgm6G/hqki1kjA2dX+43Vc/Q==
X-Received: by 2002:a05:6102:c8a:b0:4df:9635:210d with SMTP id ada2fe7eead31-4e6e41db7c6mr17267897137.23.1748977517408;
        Tue, 03 Jun 2025 12:05:17 -0700 (PDT)
Received: from gama-Inspiron-15-3530.. ([2804:18:607d:c1ba:6875:4995:e343:e77c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64442b6a9sm9302411137.6.2025.06.03.12.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 12:05:17 -0700 (PDT)
From: Ramon Fontes <ramonreisfontes@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH] Integration with the user space
Date: Tue,  3 Jun 2025 16:05:06 -0300
Message-ID: <20250603190506.6382-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This PR introduces support for use space tools such as wmediumd in the mac802154_hwsim kernel module, similar to the existing support for Wi-Fi simulations via mac80211_hwsim. With this addition, it becomes possible to simulate interference and control transmission behavior in IEEE 802.15.4 networks using a userspace backend.

Key changes:

* Introduced communication between mac802154_hwsim and the wmediumd daemon via netlink.
* Included a packet queue (skb_queue) that ensures packets are only transmitted after validation by wmediumd.
* Integrated support to consult wmediumd before transmitting packets, enabling the simulation of interference or transmission failure.

Backward Compatibility:

The current behavior of mac802154_hwsim remains unchanged when wmediumd is not running. If the daemon is unavailable or disabled, the module continues to operate normally, ensuring full compatibility with existing tools and workflows.

Purpose:

Enable more realistic simulations of IEEE 802.15.4-based sensor and IoT networks, accounting for factors like interference, link quality, and connectivity. This fills a gap in current emulation tools where mac802154_hwsim lacks channel behavior modeling.

Testing:

A wmediumd release for mac802154_hwsim is available at https://github.com/ramonfontes/wmediumd_802154/ and you can follow updated instructions there. However, you can also follow the steps below:

1. Building wmediumd_802154:

$ cd wmediumd_802154
$ make
$ sudo make install

2. Loading the modified mac802154_hwsim kernel module (this PR)

$ sudo modprobe mac802154_hwsim radios=3

3. Running wmediumd_802154

$ cd tests
$ sudo ./interference.sh
$ sudo wmediumd_802154 -s -c tree.cfg

4. Terminal 1: Pinging virtual sensors

The network topology of tree.cfg looks like below:

s1 -- s0 -- s2

s2 is too far away from s0 and the communication between s0 and s2 is not possible. You can now test connectivity between the virtual sensors using IPv6 link-local addresses.

Ping from sensor0 to sensor1:

ping -c 2 fe80::2
PING fe80::2 (fe80::2) 56 data bytes
64 bytes from fe80::2%pan0: icmp_seq=1 ttl=64 time=2.33 ms
64 bytes from fe80::2%pan0: icmp_seq=2 ttl=64 time=1.77 ms

--- fe80::2 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 1.770/2.051/2.332/0.281 ms

Ping from sensor0 to sensor2:

ping -c 2 fe80::3
PING fe80::3 (fe80::3) 56 data bytes
--- fe80::3 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1054ms

Simulated custom topologies using Mininet-WiFi with 802.15.4 support is also possible by running https://github.com/intrig-unicamp/mininet-wifi/blob/9f2cba0d6ebcfebf6c19161b81b6186cfa110cca/examples/wmediumd_interference_lowpan.py

Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 975 ++++++++++++++++++++++-
 drivers/net/ieee802154/mac802154_hwsim.h |  57 +-
 2 files changed, 999 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 2f7520454..782aba5fa 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/platform_device.h>
+#include <linux/debugfs.h>
 #include <linux/rtnetlink.h>
 #include <linux/netdevice.h>
 #include <linux/device.h>
@@ -22,13 +23,23 @@
 #include <net/mac802154.h>
 #include <net/cfg802154.h>
 #include <net/genetlink.h>
+#include <net/netns/generic.h>
+#include <linux/rhashtable.h>
 #include "mac802154_hwsim.h"
+#include <linux/virtio.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
 
 MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac802154");
 MODULE_LICENSE("GPL");
 
+static int radios = 2;
+module_param(radios, int, 0444);
+MODULE_PARM_DESC(radios, "Number of simulated radios");
+
 static LIST_HEAD(hwsim_phys);
 static DEFINE_MUTEX(hwsim_phys_lock);
+static int hwsim_radios_generation = 1;
 
 static struct platform_device *mac802154hwsim_dev;
 
@@ -37,6 +48,50 @@ static struct genl_family hwsim_genl_family;
 
 static int hwsim_radio_idx;
 
+static unsigned int hwsim_net_id;
+
+static DEFINE_IDA(hwsim_netgroup_ida);
+
+static struct class *hwsim_class;
+
+struct hwsim_net {
+	int netgroup;
+	u32 wmediumd;
+};
+
+struct hwsim_cb {
+	uintptr_t cookie;
+};
+
+static inline u32 hwsim_net_get_wmediumd(struct net *net)
+{
+	struct hwsim_net *hwsim_net = net_generic(net, hwsim_net_id);
+
+	return hwsim_net->wmediumd;
+}
+
+static inline void hwsim_net_set_wmediumd(struct net *net, u32 portid)
+{
+	struct hwsim_net *hwsim_net = net_generic(net, hwsim_net_id);
+
+	hwsim_net->wmediumd = portid;
+}
+
+static inline int hwsim_net_get_netgroup(struct net *net)
+{
+	struct hwsim_net *hwsim_net = net_generic(net, hwsim_net_id);
+
+	return hwsim_net->netgroup;
+}
+
+static inline int hwsim_net_set_netgroup(struct net *net)
+{
+	struct hwsim_net *hwsim_net = net_generic(net, hwsim_net_id);
+
+	hwsim_net->netgroup = ida_alloc(&hwsim_netgroup_ida, GFP_KERNEL);
+	return hwsim_net->netgroup >= 0 ? 0 : -ENOMEM;
+}
+
 enum hwsim_multicast_groups {
 	HWSIM_MCGRP_CONFIG,
 };
@@ -45,6 +100,14 @@ static const struct genl_multicast_group hwsim_mcgrps[] = {
 	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
 };
 
+struct hwsim_pending_tx {
+	struct ieee802154_hw *hw;
+	struct sk_buff *skb;
+	struct list_head list;
+};
+
+static LIST_HEAD(pending_tx_list);
+
 struct hwsim_pib {
 	u8 page;
 	u8 channel;
@@ -73,13 +136,42 @@ struct hwsim_phy {
 	u32 idx;
 
 	struct hwsim_pib __rcu *pib;
+	bool rht_inserted;
+	u8 ieee_addr[8];
+
+	struct rhash_head rht;
+	struct dentry *debugfs;
+	atomic_t pending_cookie;
+	struct sk_buff_head pending;
+	struct sk_buff *pending_skb;
+	struct device *dev;
+	struct mutex mutex;
+
+	bool destroy_on_close;
+	u32 portid;
 
 	bool suspended;
 	struct list_head edges;
 
 	struct list_head list;
+
+	/* group shared by radios created in the same netns */
+	int netgroup;
+	/* wmediumd portid responsible for netgroup of this radio */
+	u32 wmediumd;
 };
 
+static const struct rhashtable_params hwsim_rht_params = {
+	.nelem_hint = 2,
+	.automatic_shrinking = true,
+	.key_len = 8, /* ETH_ALEN */
+	.key_offset = offsetof(struct hwsim_phy, ieee_addr),
+	.head_offset = offsetof(struct hwsim_phy, rht),
+};
+
+static DEFINE_SPINLOCK(hwsim_radio_lock);
+static struct rhashtable hwsim_radios_rht;
+
 static int hwsim_add_one(struct genl_info *info, struct device *dev,
 			 bool init);
 static void hwsim_del(struct hwsim_phy *phy);
@@ -91,6 +183,17 @@ static int hwsim_hw_ed(struct ieee802154_hw *hw, u8 *level)
 	return 0;
 }
 
+static void hwsim_mcast_config_msg(struct sk_buff *mcast_skb,
+				   struct genl_info *info)
+{
+	if (info)
+		genl_notify(&hwsim_genl_family, mcast_skb, info,
+			    HWSIM_MCGRP_CONFIG, GFP_KERNEL);
+	else
+		genlmsg_multicast(&hwsim_genl_family, mcast_skb, 0,
+				  HWSIM_MCGRP_CONFIG, GFP_KERNEL);
+}
+
 static int hwsim_update_pib(struct ieee802154_hw *hw, u8 page, u8 channel,
 			    struct ieee802154_hw_addr_filt *filt,
 			    enum ieee802154_filtering_level filt_level)
@@ -114,9 +217,15 @@ static int hwsim_update_pib(struct ieee802154_hw *hw, u8 page, u8 channel,
 
 	rcu_assign_pointer(phy->pib, pib);
 	kfree_rcu(pib_old, rcu);
+
 	return 0;
 }
 
+static struct hwsim_phy *get_hwsim_data_ref_from_addr(const u8 *addr)
+{
+	return rhashtable_lookup_fast(&hwsim_radios_rht, addr, hwsim_rht_params);
+}
+
 static int hwsim_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	struct hwsim_phy *phy = hw->priv;
@@ -147,6 +256,140 @@ static int hwsim_hw_addr_filt(struct ieee802154_hw *hw,
 	return ret;
 }
 
+static int hwsim_unicast_netgroup(struct hwsim_phy *data,
+				  struct sk_buff *skb, int portid)
+{
+	struct net *net;
+	bool found = false;
+	int res = -ENOENT;
+
+	rcu_read_lock();
+	for_each_net_rcu(net) {
+		if (data->netgroup == hwsim_net_get_netgroup(net)) {
+			res = genlmsg_unicast(net, skb, portid);
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	if (!found)
+		nlmsg_free(skb);
+
+	return res;
+}
+
+#if IS_REACHABLE(CONFIG_VIRTIO)
+
+/* MAC80211_HWSIM virtio queues */
+static struct virtqueue *hwsim_vqs[HWSIM_NUM_VQS];
+static bool hwsim_virtio_enabled;
+static DEFINE_SPINLOCK(hwsim_virtio_lock);
+
+static void hwsim_virtio_rx_work(struct work_struct *work);
+static DECLARE_WORK(hwsim_virtio_rx, hwsim_virtio_rx_work);
+
+static int hwsim_tx_virtio(struct hwsim_phy *phy,
+			   struct sk_buff *skb)
+{
+	struct scatterlist sg[1];
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (!hwsim_virtio_enabled) {
+		err = -ENODEV;
+		goto out_free;
+	}
+
+	sg_init_one(sg, skb->head, skb_end_offset(skb));
+	err = virtqueue_add_outbuf(hwsim_vqs[HWSIM_VQ_TX], sg, 1, skb,
+				   GFP_ATOMIC);
+	if (err)
+		goto out_free;
+	virtqueue_kick(hwsim_vqs[HWSIM_VQ_TX]);
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+	return 0;
+
+out_free:
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+	nlmsg_free(skb);
+	return err;
+}
+#else
+/* cause a linker error if this ends up being needed */
+extern int hwsim_tx_virtio(struct hwsim_phy *phy,
+			   struct sk_buff *skb);
+#define hwsim_virtio_enabled false
+#endif
+
+static void mac802154_hwsim_tx_frame_nl(struct ieee802154_hw *hw, struct sk_buff *my_skb,
+			     int dst_portid)
+{
+	struct sk_buff *skb;
+	struct hwsim_phy *phy = hw->priv;
+	void *msg_head;
+	unsigned int hwsim_flags = 0;
+	uintptr_t cookie;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+
+	if (skb == NULL)
+		goto nla_put_failure;
+
+	msg_head = genlmsg_put(skb, 0, 0, &hwsim_genl_family, 0,
+			       MAC802154_HWSIM_CMD_FRAME);
+	if (msg_head == NULL) {
+		pr_debug("mac802154_hwsim: problem with msg_head\n");
+		goto nla_put_failure;
+	}
+
+	u8 addr_buf[8];
+	put_unaligned_le64(hw->phy->perm_extended_addr, addr_buf);
+	put_unaligned_le64(hw->phy->perm_extended_addr, phy->ieee_addr);
+
+	if (nla_put(skb, MAC802154_HWSIM_ATTR_ADDR_TRANSMITTER,
+		    8, addr_buf))
+		goto nla_put_failure;
+
+	/* We get the skb->data */
+	if (nla_put(skb, MAC802154_HWSIM_ATTR_FRAME, my_skb->len, my_skb->data))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, MAC802154_HWSIM_ATTR_FLAGS, hwsim_flags))
+		goto nla_put_failure;
+
+	/* We create a cookie to identify this skb */
+	cookie = atomic_inc_return(&phy->pending_cookie);
+
+	if (nla_put_u64_64bit(skb, MAC802154_HWSIM_ATTR_COOKIE, cookie, MAC802154_HWSIM_ATTR_PAD))
+		goto nla_put_failure;
+
+	genlmsg_end(skb, msg_head);
+
+	struct sk_buff *skb_2 = skb_clone(my_skb, GFP_ATOMIC);
+	if (!skb_2)
+		goto err_free_txskb;
+
+	if (hwsim_virtio_enabled) {
+		if (hwsim_tx_virtio(phy, skb))
+			goto err_free_txskb;
+	} else {
+		if (hwsim_unicast_netgroup(phy, skb, dst_portid))
+			goto err_free_txskb;
+	}
+
+	/* Enqueue the packet */
+	skb_queue_tail(&phy->pending, skb_2);
+
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+err_free_txskb:
+	pr_debug("mac802154_hwsim: error occurred in %s\n", __func__);
+}
+
 static void hwsim_hw_receive(struct ieee802154_hw *hw, struct sk_buff *skb,
 			     u8 lqi)
 {
@@ -259,25 +502,142 @@ static int hwsim_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct hwsim_pib *current_pib, *endpoint_pib;
 	struct hwsim_edge_info *einfo;
 	struct hwsim_edge *e;
+	u32 _portid;
 
 	WARN_ON(current_phy->suspended);
 
+	/* wmediumd mode check */
+	_portid = READ_ONCE(current_phy->wmediumd);
+
+	if (_portid || hwsim_virtio_enabled){
+		mac802154_hwsim_tx_frame_nl(hw, skb, _portid);
+
+		ieee802154_xmit_complete(hw, skb, false);
+		return 0;
+	}
+	else{
+		rcu_read_lock();
+		current_pib = rcu_dereference(current_phy->pib);
+
+		list_for_each_entry_rcu(e, &current_phy->edges, list) {
+			/* Can be changed later in rx_irqsafe, but this is only a
+			* performance tweak. Received radio should drop the frame
+			* in mac802154 stack anyway... so we don't need to be
+			* 100% of locking here to check on suspended
+			*/
+			if (e->endpoint->suspended)
+				continue;
+
+			endpoint_pib = rcu_dereference(e->endpoint->pib);
+			if (current_pib->page == endpoint_pib->page &&
+				current_pib->channel == endpoint_pib->channel) {
+					struct sk_buff *newskb = pskb_copy(skb, GFP_ATOMIC);
+
+					einfo = rcu_dereference(e->info);
+					if (newskb)
+						hwsim_hw_receive(e->endpoint->hw, newskb, einfo->lqi);
+			}
+		}
+		rcu_read_unlock();
+
+		ieee802154_xmit_complete(hw, skb, false);
+		return 0;
+	}
+}
+
+static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
+					  struct genl_info *info)
+{
+	struct hwsim_phy *data2;
+	struct ieee802154_hdr *hdr;
+	const u8 *dst;
+	int frame_data_len;
+	void *frame_data;
+	struct sk_buff *skb = NULL;
+	struct hwsim_pib *current_pib, *endpoint_pib;
+	struct hwsim_edge *e;
+	struct hwsim_edge_info *einfo;
+
+	if (!info->attrs[MAC802154_HWSIM_ATTR_ADDR_RECEIVER] ||
+	    !info->attrs[MAC802154_HWSIM_ATTR_FRAME])
+		goto out;
+
+	dst = (void *)nla_data(info->attrs[MAC802154_HWSIM_ATTR_ADDR_RECEIVER]);
+	frame_data_len = nla_len(info->attrs[MAC802154_HWSIM_ATTR_FRAME]);
+	frame_data = (void *)nla_data(info->attrs[MAC802154_HWSIM_ATTR_FRAME]);
+
+	if (frame_data_len < IEEE802154_MIN_HDR_LEN ||
+		frame_data_len > IEEE802154_MAX_FRAME_LEN)
+		goto err;
+
+	/* Allocate new skb here */
+	skb = alloc_skb(frame_data_len, GFP_KERNEL);
+	if (skb == NULL)
+		goto err;
+
+	/* Copy the data */
+	skb_put_data(skb, frame_data, frame_data_len);
+
+	ieee802154_hdr_peek_addrs(skb, hdr);
+
+	u8 *frame = frame_data;
+	u16 fcf = le16_to_cpup((__le16 *)frame);
+	u8 *ptr = frame + 3;
+
+	u8 src_addr[8];
+	u8 dst_addr_mode = (fcf >> 10) & 0x3;
+	u8 src_addr_mode = (fcf >> 14) & 0x3;
+	bool intra_pan = (fcf >> 6) & 0x1;
+
+	/* skip the destination */
+	if (dst_addr_mode == IEEE802154_ADDR_SHORT) {
+		/* dest_pan + short addr */
+		ptr += 2 + 2;
+	} else if (dst_addr_mode == IEEE802154_ADDR_LONG) {
+		/* dest_pan + extended addr */
+		ptr += 2 + 8;
+	}
+
+	/* src_pan */
+	if (!intra_pan)
+		ptr += 2;
+
+	if (src_addr_mode == IEEE802154_ADDR_SHORT)
+		goto out;
+	else if (src_addr_mode == IEEE802154_ADDR_LONG)
+		memcpy(src_addr, ptr, 8);
+
+	data2 = get_hwsim_data_ref_from_addr(src_addr);
+	if (!data2)
+		goto out;
+
+	struct ieee802154_hw *hw = data2->hw;
+
+	struct hwsim_phy *current_phy = hw->priv;
+
 	rcu_read_lock();
 	current_pib = rcu_dereference(current_phy->pib);
 	list_for_each_entry_rcu(e, &current_phy->edges, list) {
 		/* Can be changed later in rx_irqsafe, but this is only a
-		 * performance tweak. Received radio should drop the frame
-		 * in mac802154 stack anyway... so we don't need to be
-		 * 100% of locking here to check on suspended
-		 */
+		* performance tweak. Received radio should drop the frame
+		* in mac802154 stack anyway... so we don't need to be
+		* 100% of locking here to check on suspended
+		*/
 		if (e->endpoint->suspended)
 			continue;
 
 		endpoint_pib = rcu_dereference(e->endpoint->pib);
 		if (current_pib->page == endpoint_pib->page &&
-		    current_pib->channel == endpoint_pib->channel) {
-			struct sk_buff *newskb = pskb_copy(skb, GFP_ATOMIC);
+			current_pib->channel == endpoint_pib->channel) {
+
+			struct ieee802154_hw *hw1 = e->endpoint->hw;
+			struct hwsim_phy *phy1 = hw1->priv;
+			u8* addr64 = phy1->ieee_addr;
 
+			if (dst_addr_mode == IEEE802154_ADDR_LONG && memcmp(dst, addr64, 8) != 0)
+				continue;
+
+			struct sk_buff *newskb = pskb_copy(skb, GFP_ATOMIC);
 			einfo = rcu_dereference(e->info);
 			if (newskb)
 				hwsim_hw_receive(e->endpoint->hw, newskb, einfo->lqi);
@@ -285,8 +645,12 @@ static int hwsim_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	}
 	rcu_read_unlock();
 
-	ieee802154_xmit_complete(hw, skb, false);
 	return 0;
+err:
+	pr_debug("mac802154_hwsim: error occurred in %s\n", __func__);
+out:
+	dev_kfree_skb(skb);
+	return -EINVAL;
 }
 
 static int hwsim_hw_start(struct ieee802154_hw *hw)
@@ -342,6 +706,36 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	return hwsim_add_one(info, &mac802154hwsim_dev->dev, false);
 }
 
+static void hwsim_mcast_del_radio(int id, const char *hwname,
+				  struct genl_info *info)
+{
+	struct sk_buff *skb;
+	void *data;
+	int ret;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	data = genlmsg_put(skb, 0, 0, &hwsim_genl_family, 0,
+			   MAC802154_HWSIM_CMD_DEL_RADIO);
+	if (!data)
+		goto error;
+
+	ret = nla_put_u32(skb, MAC802154_HWSIM_ATTR_RADIO_ID, id);
+	if (ret < 0)
+		goto error;
+
+	genlmsg_end(skb, data);
+
+	hwsim_mcast_config_msg(skb, info);
+
+	return;
+
+error:
+	nlmsg_free(skb);
+}
+
 static int hwsim_del_radio_nl(struct sk_buff *msg, struct genl_info *info)
 {
 	struct hwsim_phy *phy, *tmp;
@@ -365,6 +759,19 @@ static int hwsim_del_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	return -ENODEV;
 }
 
+static void hwsim_del_radio(struct hwsim_phy *data,
+				     const char *hwname,
+				     struct genl_info *info)
+{
+	hwsim_mcast_del_radio(data->idx, hwname, info);
+	debugfs_remove_recursive(data->debugfs);
+	ieee802154_unregister_hw(data->hw);
+	device_release_driver(data->dev);
+	device_unregister(data->dev);
+	ieee802154_free_hw(data->hw);
+}
+
+
 static int append_radio_msg(struct sk_buff *skb, struct hwsim_phy *phy)
 {
 	struct nlattr *nl_edges, *nl_edge;
@@ -459,6 +866,7 @@ static int hwsim_get_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	struct sk_buff *skb;
 	int idx, res = -ENODEV;
 
+
 	if (!info->attrs[MAC802154_HWSIM_ATTR_RADIO_ID])
 		return -EINVAL;
 	idx = nla_get_u32(info->attrs[MAC802154_HWSIM_ATTR_RADIO_ID]);
@@ -739,12 +1147,103 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	return -ENOENT;
 }
 
+static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
+					   struct genl_info *info)
+{
+	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
+	struct hwsim_edge_info *einfo, *einfo_old;
+	struct hwsim_phy *phy_v0;
+	struct hwsim_edge *e;
+	u8 lqi;
+	u32 v0, v1;
+
+	if (nla_parse_nested_deprecated(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX, info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE], hwsim_edge_policy, NULL))
+		return -EINVAL;
+
+	if (!edge_attrs[MAC802154_HWSIM_EDGE_ATTR_ENDPOINT_ID] ||
+	    !edge_attrs[MAC802154_HWSIM_EDGE_ATTR_LQI])
+		return -EINVAL;
+
+	v0 = nla_get_u32(info->attrs[MAC802154_HWSIM_ATTR_RADIO_ID]);
+	v1 = nla_get_u32(edge_attrs[MAC802154_HWSIM_EDGE_ATTR_ENDPOINT_ID]);
+	lqi = nla_get_u8(edge_attrs[MAC802154_HWSIM_EDGE_ATTR_LQI]);
+
+	mutex_lock(&hwsim_phys_lock);
+	phy_v0 = hwsim_get_radio_by_id(v0);
+	if (!phy_v0) {
+		mutex_unlock(&hwsim_phys_lock);
+		return -ENOENT;
+	}
+
+	einfo = kzalloc(sizeof(*einfo), GFP_KERNEL);
+	if (!einfo) {
+		mutex_unlock(&hwsim_phys_lock);
+		return -ENOMEM;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
+		if (e->endpoint->idx == v1) {
+			einfo->lqi = lqi;
+			einfo_old = rcu_replace_pointer(e->info, einfo,
+							lockdep_is_held(&hwsim_phys_lock));
+			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
+			mutex_unlock(&hwsim_phys_lock);
+			return 0;
+		}
+	}
+	rcu_read_unlock();
+
+	kfree(einfo);
+	mutex_unlock(&hwsim_phys_lock);
+
+	return -ENOENT;
+}
+
+static void hwsim_register_wmediumd(struct net *net, u32 portid)
+{
+	struct hwsim_phy *data;
+
+	hwsim_net_set_wmediumd(net, portid);
+
+	spin_lock_bh(&hwsim_radio_lock);
+	list_for_each_entry(data, &hwsim_phys, list) {
+		if (data->netgroup == hwsim_net_get_netgroup(net))
+			data->wmediumd = portid;
+	}
+	spin_unlock_bh(&hwsim_radio_lock);
+}
+
+static int hwsim_register_received_nl(struct sk_buff *msg, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	int chans = 1;
+
+	if (chans > 1)
+		return -EOPNOTSUPP;
+
+	if (hwsim_net_get_wmediumd(net))
+		return -EBUSY;
+
+	hwsim_register_wmediumd(net, info->snd_portid);
+
+	pr_debug("mac802154_hwsim: received a REGISTER, "
+	       "switching to wmediumd mode with pid %d\n", info->snd_portid);
+
+	return 0;
+}
+
 /* MAC802154_HWSIM netlink policy */
 
 static const struct nla_policy hwsim_genl_policy[MAC802154_HWSIM_ATTR_MAX + 1] = {
 	[MAC802154_HWSIM_ATTR_RADIO_ID] = { .type = NLA_U32 },
 	[MAC802154_HWSIM_ATTR_RADIO_EDGE] = { .type = NLA_NESTED },
 	[MAC802154_HWSIM_ATTR_RADIO_EDGES] = { .type = NLA_NESTED },
+	[MAC802154_HWSIM_ATTR_ADDR_RECEIVER] = { .type = NLA_BINARY, .len = 8 },
+	[MAC802154_HWSIM_ATTR_ADDR_TRANSMITTER] = { .type = NLA_BINARY, .len = 8 },
+	[MAC802154_HWSIM_ATTR_FRAME] = { .type = NLA_BINARY,
+			       .len = IEEE802154_MAX_FRAME_LEN },
 };
 
 /* Generic Netlink operations array */
@@ -785,6 +1284,22 @@ static const struct genl_small_ops hwsim_nl_ops[] = {
 		.doit = hwsim_set_edge_lqi,
 		.flags = GENL_UNS_ADMIN_PERM,
 	},
+	{
+		.cmd = MAC802154_HWSIM_CMD_REGISTER,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = hwsim_register_received_nl,
+		.flags = GENL_UNS_ADMIN_PERM,
+	},
+	{
+		.cmd = MAC802154_HWSIM_CMD_TX_INFO_FRAME,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = hwsim_tx_info_frame_received_nl,
+	},
+	{
+		.cmd = MAC802154_HWSIM_CMD_FRAME,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = hwsim_cloned_frame_received_nl,
+	},
 };
 
 static struct genl_family hwsim_genl_family __ro_after_init = {
@@ -792,25 +1307,15 @@ static struct genl_family hwsim_genl_family __ro_after_init = {
 	.version = 1,
 	.maxattr = MAC802154_HWSIM_ATTR_MAX,
 	.policy = hwsim_genl_policy,
+	.netnsok = true,
 	.module = THIS_MODULE,
 	.small_ops = hwsim_nl_ops,
 	.n_small_ops = ARRAY_SIZE(hwsim_nl_ops),
-	.resv_start_op = MAC802154_HWSIM_CMD_NEW_EDGE + 1,
+	.resv_start_op = MAC802154_HWSIM_CMD_TX_INFO_FRAME + 1,
 	.mcgrps = hwsim_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
 };
 
-static void hwsim_mcast_config_msg(struct sk_buff *mcast_skb,
-				   struct genl_info *info)
-{
-	if (info)
-		genl_notify(&hwsim_genl_family, mcast_skb, info,
-			    HWSIM_MCGRP_CONFIG, GFP_KERNEL);
-	else
-		genlmsg_multicast(&hwsim_genl_family, mcast_skb, 0,
-				  HWSIM_MCGRP_CONFIG, GFP_KERNEL);
-}
-
 static void hwsim_mcast_new_radio(struct genl_info *info, struct hwsim_phy *phy)
 {
 	struct sk_buff *mcast_skb;
@@ -899,8 +1404,10 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	struct ieee802154_hw *hw;
 	struct hwsim_phy *phy;
 	struct hwsim_pib *pib;
+	struct net *net;
 	int idx;
 	int err;
+	int ret;
 
 	idx = hwsim_radio_idx++;
 
@@ -908,9 +1415,17 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	if (!hw)
 		return -ENOMEM;
 
+	if (info)
+		net = genl_info_net(info);
+	else
+		net = &init_net;
+	wpan_phy_net_set(hw->phy, net);
+
 	phy = hw->priv;
 	phy->hw = hw;
 
+	skb_queue_head_init(&phy->pending);
+
 	/* 868 MHz BPSK	802.15.4-2003 */
 	hw->phy->supported.channels[0] |= 1;
 	/* 915 MHz BPSK	802.15.4-2003 */
@@ -943,6 +1458,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	hw->phy->supported.channels[6] |= 0x3ffc00;
 
 	hw->phy->perm_extended_addr = cpu_to_le64(((u64)0x02 << 56) | ((u64)idx));
+	memcpy(phy->ieee_addr, &hw->phy->perm_extended_addr, 8);
 
 	/* hwsim phy channel 13 as default */
 	hw->phy->current_channel = 13;
@@ -952,6 +1468,9 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 		goto err_pib;
 	}
 
+	if (info)
+		phy->portid = info->snd_portid;
+
 	pib->channel = 13;
 	pib->filt.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 	pib->filt.pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
@@ -962,6 +1481,9 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	hw->flags = IEEE802154_HW_PROMISCUOUS;
 	hw->parent = dev;
 
+	phy->netgroup = hwsim_net_get_netgroup(net);
+	phy->wmediumd = hwsim_net_get_wmediumd(net);
+
 	err = ieee802154_register_hw(hw);
 	if (err)
 		goto err_reg;
@@ -977,10 +1499,20 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 	list_add_tail(&phy->list, &hwsim_phys);
 	mutex_unlock(&hwsim_phys_lock);
 
+	ret = rhashtable_insert_fast(&hwsim_radios_rht, &phy->rht, hwsim_rht_params);
+	if (ret < 0) {
+		pr_err("Error in adding PHY into rhashtable: %d\n", ret);
+		goto failed_final_insert;
+	}
+	phy->rht_inserted = true;
+
 	hwsim_mcast_new_radio(info, phy);
 
 	return idx;
 
+failed_final_insert:
+	debugfs_remove_recursive(phy->debugfs);
+	ieee802154_unregister_hw(phy->hw);
 err_subscribe:
 	ieee802154_unregister_hw(phy->hw);
 err_reg:
@@ -1011,6 +1543,7 @@ static void hwsim_del(struct hwsim_phy *phy)
 
 	ieee802154_unregister_hw(phy->hw);
 	ieee802154_free_hw(phy->hw);
+	class_destroy(hwsim_class);
 }
 
 static int hwsim_probe(struct platform_device *pdev)
@@ -1018,13 +1551,13 @@ static int hwsim_probe(struct platform_device *pdev)
 	struct hwsim_phy *phy, *tmp;
 	int err, i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < radios; i++) {
 		err = hwsim_add_one(NULL, &pdev->dev, true);
 		if (err < 0)
 			goto err_slave;
 	}
 
-	dev_info(&pdev->dev, "Added 2 mac802154 hwsim hardware radios\n");
+	dev_info(&pdev->dev, "Added %d mac802154 hwsim hardware radios\n", radios);
 	return 0;
 
 err_slave:
@@ -1053,40 +1586,420 @@ static struct platform_driver mac802154hwsim_driver = {
 	},
 };
 
-static __init int hwsim_init_module(void)
+static void remove_user_radios(u32 portid)
+{
+	struct hwsim_phy *entry, *tmp;
+	LIST_HEAD(list);
+
+	spin_lock_bh(&hwsim_radio_lock);
+	list_for_each_entry_safe(entry, tmp, &hwsim_phys, list) {
+		if (entry->destroy_on_close && entry->portid == portid) {
+			list_move(&entry->list, &list);
+			rhashtable_remove_fast(&hwsim_radios_rht, &entry->rht,
+					       hwsim_rht_params);
+			hwsim_radios_generation++;
+		}
+	}
+	spin_unlock_bh(&hwsim_radio_lock);
+
+	list_for_each_entry_safe(entry, tmp, &list, list) {
+		list_del(&entry->list);
+		hwsim_del_radio(entry, wpan_phy_name(entry->hw->phy),
+					 NULL);
+	}
+}
+
+static int mac802154_hwsim_netlink_notify(struct notifier_block *nb,
+					 unsigned long state,
+					 void *_notify)
+{
+	struct netlink_notify *notify = _notify;
+
+	if (state != NETLINK_URELEASE)
+		return NOTIFY_DONE;
+
+	remove_user_radios(notify->portid);
+
+	if (notify->portid == hwsim_net_get_wmediumd(notify->net)) {
+		printk(KERN_INFO "mac802154_hwsim: wmediumd released netlink"
+		       " socket, switching to perfect channel medium\n");
+		hwsim_register_wmediumd(notify->net, 0);
+	}
+	return NOTIFY_DONE;
+
+}
+
+static void __net_exit hwsim_exit_net(struct net *net)
+{
+	struct hwsim_phy *data, *tmp;
+	LIST_HEAD(list);
+
+	spin_lock_bh(&hwsim_radio_lock);
+	list_for_each_entry_safe(data, tmp, &hwsim_phys, list) {
+		if (!net_eq(wpan_phy_net(data->hw->phy), net))
+			continue;
+
+		/* Radios created in init_net are returned to init_net. */
+		if (data->netgroup == hwsim_net_get_netgroup(&init_net))
+			continue;
+
+		list_move(&data->list, &list);
+		rhashtable_remove_fast(&hwsim_radios_rht, &data->rht,
+				       hwsim_rht_params);
+		hwsim_radios_generation++;
+	}
+	spin_unlock_bh(&hwsim_radio_lock);
+
+	list_for_each_entry_safe(data, tmp, &list, list) {
+		list_del(&data->list);
+		hwsim_del_radio(data,
+					 wpan_phy_name(data->hw->phy),
+					 NULL);
+	}
+
+	ida_free(&hwsim_netgroup_ida, hwsim_net_get_netgroup(net));
+}
+
+#if IS_REACHABLE(CONFIG_VIRTIO)
+
+static void hwsim_virtio_tx_done(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	while ((skb = virtqueue_get_buf(vq, &len)))
+		dev_kfree_skb_irq(skb);
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+}
+
+static int hwsim_virtio_handle_cmd(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh;
+	struct genlmsghdr *gnlh;
+	struct nlattr *tb[MAC802154_HWSIM_ATTR_MAX + 1];
+	struct genl_info info = {};
+	int err;
+
+	nlh = nlmsg_hdr(skb);
+	gnlh = nlmsg_data(nlh);
+
+	if (skb->len < nlh->nlmsg_len)
+		return -EINVAL;
+
+	err = genlmsg_parse(nlh, &hwsim_genl_family, tb, MAC802154_HWSIM_ATTR_MAX,
+			    hwsim_genl_policy, NULL);
+	if (err) {
+		pr_err_ratelimited("hwsim: genlmsg_parse returned %d\n", err);
+		return err;
+	}
+
+	info.attrs = tb;
+
+	switch (gnlh->cmd) {
+	/*case MAC802154_HWSIM_CMD_FRAME:
+		hwsim_cloned_frame_received_nl(skb, &info);
+		break;
+	case MAC802154_HWSIM_CMD_TX_INFO_FRAME:
+		hwsim_tx_info_frame_received_nl(skb, &info);
+		break;
+	case HWSIM_CMD_REPORT_PMSR:
+		hwsim_pmsr_report_nl(skb, &info);
+		break;*/
+	default:
+		pr_err_ratelimited("hwsim: invalid cmd: %d\n", gnlh->cmd);
+		return -EPROTO;
+	}
+	return 0;
+}
+
+static void hwsim_virtio_rx_work(struct work_struct *work)
+{
+	struct virtqueue *vq;
+	unsigned int len;
+	struct sk_buff *skb;
+	struct scatterlist sg[1];
+	int err;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (!hwsim_virtio_enabled)
+		goto out_unlock;
+
+	skb = virtqueue_get_buf(hwsim_vqs[HWSIM_VQ_RX], &len);
+	if (!skb)
+		goto out_unlock;
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+
+	skb->data = skb->head;
+	skb_reset_tail_pointer(skb);
+	skb_put(skb, len);
+	hwsim_virtio_handle_cmd(skb);
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (!hwsim_virtio_enabled) {
+		dev_kfree_skb_irq(skb);
+		goto out_unlock;
+	}
+	vq = hwsim_vqs[HWSIM_VQ_RX];
+	sg_init_one(sg, skb->head, skb_end_offset(skb));
+	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_ATOMIC);
+	if (WARN(err, "virtqueue_add_inbuf returned %d\n", err))
+		dev_kfree_skb_irq(skb);
+	else
+		virtqueue_kick(vq);
+	schedule_work(&hwsim_virtio_rx);
+
+out_unlock:
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+}
+
+static void hwsim_virtio_rx_done(struct virtqueue *vq)
+{
+	schedule_work(&hwsim_virtio_rx);
+}
+
+static int init_vqs(struct virtio_device *vdev)
+{
+	struct virtqueue_info vqs_info[HWSIM_NUM_VQS] = {
+		[HWSIM_VQ_TX] = { "tx", hwsim_virtio_tx_done },
+		[HWSIM_VQ_RX] = { "rx", hwsim_virtio_rx_done },
+	};
+
+	return virtio_find_vqs(vdev, HWSIM_NUM_VQS,
+			       hwsim_vqs, vqs_info, NULL);
+}
+
+static int fill_vq(struct virtqueue *vq)
+{
+	int i, err;
+	struct sk_buff *skb;
+	struct scatterlist sg[1];
+
+	for (i = 0; i < virtqueue_get_vring_size(vq); i++) {
+		skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+
+		sg_init_one(sg, skb->head, skb_end_offset(skb));
+		err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
+		if (err) {
+			nlmsg_free(skb);
+			return err;
+		}
+	}
+	virtqueue_kick(vq);
+	return 0;
+}
+
+static void remove_vqs(struct virtio_device *vdev)
+{
+	int i;
+
+	virtio_reset_device(vdev);
+
+	for (i = 0; i < ARRAY_SIZE(hwsim_vqs); i++) {
+		struct virtqueue *vq = hwsim_vqs[i];
+		struct sk_buff *skb;
+
+		while ((skb = virtqueue_detach_unused_buf(vq)))
+			nlmsg_free(skb);
+	}
+
+	vdev->config->del_vqs(vdev);
+}
+
+static int hwsim_virtio_probe(struct virtio_device *vdev)
+{
+	int err;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (hwsim_virtio_enabled) {
+		spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+		return -EEXIST;
+	}
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+
+	err = init_vqs(vdev);
+	if (err)
+		return err;
+
+	virtio_device_ready(vdev);
+
+	err = fill_vq(hwsim_vqs[HWSIM_VQ_RX]);
+	if (err)
+		goto out_remove;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	hwsim_virtio_enabled = true;
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+
+	schedule_work(&hwsim_virtio_rx);
+	return 0;
+
+out_remove:
+	remove_vqs(vdev);
+	return err;
+}
+
+static void hwsim_virtio_remove(struct virtio_device *vdev)
+{
+	hwsim_virtio_enabled = false;
+
+	cancel_work_sync(&hwsim_virtio_rx);
+
+	remove_vqs(vdev);
+}
+
+/* MAC802154_HWSIM virtio device id table */
+static const struct virtio_device_id id_table[] = {
+	{ 42, VIRTIO_DEV_ANY_ID },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static struct virtio_driver virtio_hwsim = {
+	.driver.name = KBUILD_MODNAME,
+	.id_table = id_table,
+	.probe = hwsim_virtio_probe,
+	.remove = hwsim_virtio_remove,
+};
+
+static int hwsim_register_virtio_driver(void)
+{
+	return register_virtio_driver(&virtio_hwsim);
+}
+
+static void hwsim_unregister_virtio_driver(void)
+{
+	unregister_virtio_driver(&virtio_hwsim);
+}
+#else
+static inline int hwsim_register_virtio_driver(void)
+{
+	return 0;
+}
+
+static inline void hwsim_unregister_virtio_driver(void)
+{
+}
+#endif
+
+static struct notifier_block hwsim_netlink_notifier = {
+	.notifier_call = mac802154_hwsim_netlink_notify,
+};
+
+static int __init hwsim_init_netlink(void)
 {
 	int rc;
 
+	printk(KERN_INFO "mac802154_hwsim: initializing netlink\n");
+
 	rc = genl_register_family(&hwsim_genl_family);
 	if (rc)
-		return rc;
+		goto failure;
+
+	rc = netlink_register_notifier(&hwsim_netlink_notifier);
+	if (rc) {
+		genl_unregister_family(&hwsim_genl_family);
+		goto failure;
+	}
+
+	return 0;
+
+failure:
+	pr_debug("mac802154_hwsim: error occurred in %s\n", __func__);
+	return -EINVAL;
+}
+
+static __net_init int hwsim_init_net(struct net *net)
+{
+	return hwsim_net_set_netgroup(net);
+}
+
+static struct pernet_operations hwsim_net_ops = {
+	.init = hwsim_init_net,
+	.exit = hwsim_exit_net,
+	.id   = &hwsim_net_id,
+	.size = sizeof(struct hwsim_net),
+};
+
+static void hwsim_exit_netlink(void)
+{
+	/* unregister the notifier */
+	netlink_unregister_notifier(&hwsim_netlink_notifier);
+	/* unregister the family */
+	genl_unregister_family(&hwsim_genl_family);
+}
+
+static __init int hwsim_init_module(void)
+{
+	int rc, err;
+
+	if (radios < 0)
+		return -EINVAL;
+
+	err = rhashtable_init(&hwsim_radios_rht, &hwsim_rht_params);
+	if (err)
+		return err;
+
+	err = register_pernet_device(&hwsim_net_ops);
+	if (err)
+		goto out_free_rht;
+
+	err = hwsim_init_netlink();
+	if (err)
+		goto out_unregister_driver;
+
+	err = hwsim_register_virtio_driver();
+	if (err)
+		goto out_exit_netlink;
+
+	hwsim_class = class_create("mac802154_hwsim");
+	if (IS_ERR(hwsim_class)) {
+		err = PTR_ERR(hwsim_class);
+		goto out_exit_virtio;
+	}
 
 	mac802154hwsim_dev = platform_device_register_simple("mac802154_hwsim",
 							     -1, NULL, 0);
 	if (IS_ERR(mac802154hwsim_dev)) {
 		rc = PTR_ERR(mac802154hwsim_dev);
-		goto platform_dev;
+		goto out_unregister_driver;
 	}
 
 	rc = platform_driver_register(&mac802154hwsim_driver);
 	if (rc < 0)
-		goto platform_drv;
+		goto out_unregister_pernet;
 
 	return 0;
 
-platform_drv:
-	platform_device_unregister(mac802154hwsim_dev);
-platform_dev:
-	genl_unregister_family(&hwsim_genl_family);
+out_exit_virtio:
+	hwsim_unregister_virtio_driver();
+out_exit_netlink:
+	hwsim_exit_netlink();
+out_unregister_pernet:
+	unregister_pernet_device(&hwsim_net_ops);
 	return rc;
+out_unregister_driver:
+	platform_driver_unregister(&mac802154hwsim_driver);
+out_free_rht:
+	rhashtable_destroy(&hwsim_radios_rht);
+	return err;
 }
 
 static __exit void hwsim_remove_module(void)
 {
-	genl_unregister_family(&hwsim_genl_family);
+	pr_debug("mac80211_hwsim: unregister radios\n");
+	hwsim_unregister_virtio_driver();
+	hwsim_exit_netlink();
+	rhashtable_destroy(&hwsim_radios_rht);
 	platform_driver_unregister(&mac802154hwsim_driver);
 	platform_device_unregister(mac802154hwsim_dev);
+	unregister_pernet_device(&hwsim_net_ops);
 }
 
 module_init(hwsim_init_module);
-module_exit(hwsim_remove_module);
+module_exit(hwsim_remove_module);
\ No newline at end of file
diff --git a/drivers/net/ieee802154/mac802154_hwsim.h b/drivers/net/ieee802154/mac802154_hwsim.h
index 6c6e30e38..b1d83ff75 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.h
+++ b/drivers/net/ieee802154/mac802154_hwsim.h
@@ -1,8 +1,31 @@
 #ifndef __MAC802154_HWSIM_H
 #define __MAC802154_HWSIM_H
 
-/* mac802154 hwsim netlink commands
+
+#define IEEE802154_MAX_FRAME_LEN 127
+#define IEEE802154_MIN_HDR_LEN 3
+//#define IEEE802154_MAX_DATA_LEN (IEEE802154_PHY_FRAME_LEN - IEEE802154_MAX_HEADER_LEN)
+/**
+ * enum hwsim_tx_control_flags - flags to describe transmission info/status
+ *
+ * These flags are used to give the wmediumd extra information in order to
+ * modify its behavior for each frame
+ *
+ * @HWSIM_TX_CTL_REQ_TX_STATUS: require TX status callback for this frame.
+ * @HWSIM_TX_CTL_NO_ACK: tell the wmediumd not to wait for an ack
+ * @HWSIM_TX_STAT_ACK: Frame was acknowledged
  *
+ */
+enum hwsim_tx_control_flags {
+	MAC802154_HWSIM_TX_CTL_REQ_TX_STATUS		= BIT(0),
+	MAC802154_HWSIM_TX_CTL_NO_ACK			= BIT(1),
+	MAC802154_HWSIM_TX_STAT_ACK			= BIT(2),
+};
+
+
+/* mac802154 hwsim netlink commands
+ * @HWSIM_CMD_REGISTER: request to register and received all broadcasted
+ *		frames by any mac802154_hwsim radio device.
  * @MAC802154_HWSIM_CMD_UNSPEC: unspecified command to catch error
  * @MAC802154_HWSIM_CMD_GET_RADIO: fetch information about existing radios
  * @MAC802154_HWSIM_CMD_SET_RADIO: change radio parameters during runtime
@@ -28,6 +51,9 @@ enum {
 	MAC802154_HWSIM_CMD_SET_EDGE,
 	MAC802154_HWSIM_CMD_DEL_EDGE,
 	MAC802154_HWSIM_CMD_NEW_EDGE,
+	MAC802154_HWSIM_CMD_REGISTER,
+	MAC802154_HWSIM_CMD_FRAME,
+	MAC802154_HWSIM_CMD_TX_INFO_FRAME,
 
 	__MAC802154_HWSIM_CMD_MAX,
 };
@@ -48,6 +74,13 @@ enum {
 	MAC802154_HWSIM_ATTR_RADIO_ID,
 	MAC802154_HWSIM_ATTR_RADIO_EDGE,
 	MAC802154_HWSIM_ATTR_RADIO_EDGES,
+	MAC802154_HWSIM_ATTR_COOKIE,
+	MAC802154_HWSIM_ATTR_PAD,
+	MAC802154_HWSIM_ATTR_FRAME,
+	MAC802154_HWSIM_ATTR_ADDR_TRANSMITTER,
+	MAC802154_HWSIM_ATTR_ADDR_RECEIVER,
+	MAC802154_HWSIM_ATTR_TX_INFO,
+	MAC802154_HWSIM_ATTR_FLAGS,
 	__MAC802154_HWSIM_ATTR_MAX,
 };
 
@@ -70,4 +103,24 @@ enum {
 
 #define MAC802154_HWSIM_EDGE_ATTR_MAX (__MAC802154_HWSIM_EDGE_ATTR_MAX - 1)
 
-#endif /* __MAC802154_HWSIM_H */
+/**
+ * DOC: Frame transmission support over virtio
+ *
+ * Frame transmission is also supported over virtio to allow communication
+ * with external entities.
+ */
+
+/**
+ * enum hwsim_vqs - queues for virtio frame transmission
+ *
+ * @HWSIM_VQ_TX: send frames to external entity
+ * @HWSIM_VQ_RX: receive frames and transmission info reports
+ * @HWSIM_NUM_VQS: enum limit
+ */
+enum hwsim_vqs {
+	HWSIM_VQ_TX,
+	HWSIM_VQ_RX,
+	HWSIM_NUM_VQS,
+};
+
+#endif /* __MAC802154_HWSIM_H */
\ No newline at end of file
-- 
2.43.0

