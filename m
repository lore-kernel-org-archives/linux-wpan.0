Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:49124 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751280AbcHHJLU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Aug 2016 05:11:20 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id 5E11D42C8CAC
	for <linux-wpan@vger.kernel.org>; Mon,  8 Aug 2016 17:11:01 +0800 (CST)
From: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Subject: Problems about handling duplicate packets when frame retry is
 enabled
Date: Mon, 8 Aug 2016 09:11:04 +0000
Message-ID: <576133E7D398244EA0325FF7CE2A09E5CD55E15B@G08CNEXMBPEKD03.g08.fujitsu.local>
Content-Language: zh-CN
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi, all!

I’m using two raspberry pis with openlabs 802.15.4 radio hooked up for some experiments (Linux kernel is v4.7). Some stats like RSSI and LQI are collected and recorded by modifying wpan-ping.c. During the tests, I find some problems about handling duplicate packets.

When frame retry is enabled, it is found that the 802.15.4 module/Linux kernel could not discard duplicates, and would send the duplicates to the upper level (wpan-ping level). I check the mac receive code (/net/mac802154/rx.c), the functions __ieee802154_rx_handle_packet() and ieee802154_subif_frame() have no sub-function to handle duplicates. I also see that the similar function has been implemented in /net/mac80211/rx.c, it is the function ieee80211_rx_h_check_dup().
The duplicates need to be discarded for our experiments, the results will become more complicated otherwise. I add some codes in the function ieee802154_subif_frame(), the added codes are as below:

//part of codes in the function ieee802154_subif_frame()
switch (mac_cb(skb)->type) {
case IEEE802154_FC_TYPE_DATA:
+if (hdr->seq != sdata->last_seq) {
+    sdata->last_seq == hdr->seq;
+    return ieee802154_deliver_skb(skb);
+} else {
+    break;
+}
default:
pr_warn("ieee802154: bad frame received (type = %d)\n", mac_cb(skb)->type);
mac_cb(skb)->type);
goto fail;
//----------------------------------------------------------

The main mechanism to handle duplicates is through the comparison of sequence number between current packet (indicated by seq) and last one (indicated by last_seq). The variable last_seq is defined in the struct sdata. By the modification, the duplicates are indeed no longer received on upper layer. I'm a newbie for linux kernel, I'd like to know if the modification is ok?
If there are errors or will lead to any unexpected affects to the kernel, please feel free to point it out, thank you very much!

Best Regards,
Xue Wenqian



