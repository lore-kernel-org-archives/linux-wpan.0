Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38784 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753037AbcHTVgp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 20 Aug 2016 17:36:45 -0400
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBQcm9ibGVtcyBhYm91dCBoYW5kbGlu?=
 =?UTF-8?Q?g_duplicate_packets_when_frame_retry_is_enabled?=
References: <576133E7D398244EA0325FF7CE2A09E5CD55E15B@G08CNEXMBPEKD03.g08.fujitsu.local>
 <177f2368-0a94-079e-09ec-1093e62e5874@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55E4B8@G08CNEXMBPEKD03.g08.fujitsu.local>
 <af477ae0-0dd1-cc21-86c2-40f99d86a14a@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55FBCE@G08CNEXMBPEKD03.g08.fujitsu.local>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <d9613918-2e12-e5ae-2232-5b011182fd61@pengutronix.de>
Date: Sat, 20 Aug 2016 23:36:42 +0200
MIME-Version: 1.0
In-Reply-To: <576133E7D398244EA0325FF7CE2A09E5CD55FBCE@G08CNEXMBPEKD03.g08.fujitsu.local>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 08/19/2016 03:10 PM, Xue, Wenqian wrote:
> Hi, Alexander,
> 
> Sorry for so late reply, as I have some other business at hand.
> 
>> -----邮件原件-----
>> 发件人: Alexander Aring [mailto:aar@pengutronix.de]
>> 发送时间: 2016年8月13日 0:29
>> 收件人: Xue, Wenqian/薛 文倩 <xuewenqian@cn.fujitsu.com>
>> 抄送: linux-wpan@vger.kernel.org
>> 主题: Re: 答复: Problems about handling duplicate packets when frame retry is
>> enabled
>>
>>
...
>>
>> Your modification handles in duplicates in a form which is not acceptable. It will
>> simple drop duplicates but how frame retries works is the following:
> 
> If your meaning for my modification is that the result will be the same whether retry is enabled or not? Initially, my motivation is to prevent the received retry packet from being transmitted up to the wpan-ping level, then to avoid the error "Sequence number did not match".
> 

I looked deeper for that handling in 802.15.4-2011 (which is the version
which is currently free available):

5.1.6.6 Transmission scenarios

Your scenario is "Lost acknowledgment frame.", I don't see anything
which let me accept your patch to drop multiple received frames with the
same sequence number. The receiving node mac802154 stack is "recipient
next layer".

Or did I miss something?

>>
>> 1. Node A transmits frame for Node B with ackrequest bit set.
>> 2. Node B receive that frame and see's "ackrequest bit is set" and
>>   sending an ACK back.
>> 3. If Node A received an ack for the sequence number then no
>>   retransmission will occur.
>> OR
>> 3. If Node A doesn't received an ack it will retransmit the frame.
>>
>>
>> On your nodes and if you are really using two at86rf233 transceivers, this
>> mechanism is completely done by hardware.
>>
>> Transmit: ARET
>> Receive: AACK
>>
>> On the receive side it's always imporant that the receiving node supports AACK
>> handling if Nodes sending frames with "ackrequest bit"
>> set.
>>
>> ---
>>
>> First, you should sniff somehow the traffic if it's possible, to see what's going on
>> the traffic and you see that Node B sends ACKs back, if not -> missing AACK
>> handling.
>>
>> On linux the openlabs transceiver (at86rf233) supports AACK handling...
>> don't know if you break it with your changes.
>>
> 
> I get it for your detailed description for frame re-transmission mechanism. And yes, I really use the two at86rf233 transceivers, I also used an ieee802.15.4 sniffer to sniff the traffic, ackrequest bit is indeed set, and I could see the captured ack.
> 
> I just did some tests with the kernel v4.7 (without my duplicate modification), I did 3 cases, as below and the attachment:
> 1. set the max_frame_retries=3 for nodeA and nodeB, lots of "Sequence number did not match" errors occur during the test
> 2. set the max_frame_retries=0 for nodeA, and set the max_frame_retries=3 for nodeB, lots of "Sequence number did not match" errors occur during the test
> 3. set the max_frame_retries=3 for nodeA, and set the max_frame_retries=0 for nodeB, no above error occur
> In my goal, the retry needs to be enabled for both sides, so I'd like to know the root cause for such case.
> I also made a simple description for the test cases to make you clearer for my problem, a few typical captured packets are shown in the attachment. 
> Hope you could give some suggestions for the problem, thank you very much!
> 

Sure, retransmits can be 3 at both sides. But somehow you have a missing
acknowledgment frame. The sniff example shows me this was never send.

It could be that you transmit very fast and a force state change aborts
the transmitting of ACK frame in RX_AACK_BUSY state.

Can you try this:

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9f10da6..97f75b5 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -64,7 +64,7 @@ struct at86rf2xx_chip_data {
  *
  * We assume the max_frame_retries (7) value of 802.15.4 here.
  */
-#define AT86RF2XX_MAX_TX_RETRIES       7
+#define AT86RF2XX_MAX_TX_RETRIES       20
 /* We use the recommended 5 minutes timeout to recalibrate */
 #define AT86RF2XX_CAL_LOOP_TIMEOUT     (5 * 60 * HZ)

>> ---
>>
>> Also I detected that the ieee802154 sockets doesn't care about "iwpan dev
>> wpan0 set ackreq_default" setting [0]. This socket interface should only be used
>> as DGRAM sockets and there is a big TODO to make an enhanced version of this
>> socket interface. :-)
>>
>> But that you have retransmits smells that the [0] is set.
>>
> 
> Actually, I don't set the ackreq_default, just keep it as default.
> 
>> ---
>>
>> I am here totally confused that you don't have AACK handling which the
>> at86rf233 supports, do you really using two openlabs with mainline Linux
>> kernel? Or do you talking with some contiki/RIOT etc. node?
> 
> Sorry to make you so confused, if the email still confused you, feel free to email me. Thank you!
> 

No, I am confused because the ack handling which is handled by _hardware_
isn't working at your side, I think it's because the force state change
and I mess something with the timing settings. If so, then sorry. :-/

It should work everything with AACK handling when it's done by hardware.

- Alex
