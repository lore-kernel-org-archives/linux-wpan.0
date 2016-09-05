Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38898 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754943AbcIEIyG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2016 04:54:06 -0400
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFByb2JsZW1zIGFib3V0?=
 =?UTF-8?Q?_handling_duplicate_packets_when_frame_retry_is_enabled?=
References: <576133E7D398244EA0325FF7CE2A09E5CD55E15B@G08CNEXMBPEKD03.g08.fujitsu.local>
 <177f2368-0a94-079e-09ec-1093e62e5874@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55E4B8@G08CNEXMBPEKD03.g08.fujitsu.local>
 <af477ae0-0dd1-cc21-86c2-40f99d86a14a@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55FBCE@G08CNEXMBPEKD03.g08.fujitsu.local>
 <d9613918-2e12-e5ae-2232-5b011182fd61@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD56A6D4@G08CNEXMBPEKD02.g08.fujitsu.local>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <e3c7061c-75f6-7400-14ec-027078bf7dde@pengutronix.de>
Date: Mon, 5 Sep 2016 10:53:54 +0200
MIME-Version: 1.0
In-Reply-To: <576133E7D398244EA0325FF7CE2A09E5CD56A6D4@G08CNEXMBPEKD02.g08.fujitsu.local>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On 09/04/2016 05:06 PM, Xue, Wenqian wrote:
> Hi, Alexander
> Sorry for so late reply, and thank you for your kind attention.
> 
>> -----邮件原件-----
>> 发件人: Alexander Aring [mailto:aar@pengutronix.de]
>> 发送时间: 2016年8月21日 5:37
>> 收件人: Xue, Wenqian/薛 文倩 <xuewenqian@cn.fujitsu.com>
>> 抄送: linux-wpan@vger.kernel.org
>> 主题: Re: 答复: 答复: Problems about handling duplicate packets when frame
>> retry is enabled
>>
>>
>> Hi,
>>
>> On 08/19/2016 03:10 PM, Xue, Wenqian wrote:
>>> Hi, Alexander,
>>>
>>> Sorry for so late reply, as I have some other business at hand.
>>>
>>>> -----邮件原件-----
>>>> 发件人: Alexander Aring [mailto:aar@pengutronix.de]
>>>> 发送时间: 2016年8月13日 0:29
>>>> 收件人: Xue, Wenqian/薛 文倩 <xuewenqian@cn.fujitsu.com>
>>>> 抄送: linux-wpan@vger.kernel.org
>>>> 主题: Re: 答复: Problems about handling duplicate packets when frame
>>>> retry is enabled
>>>>
>>>>
>> ...
>>>>
>>>> Your modification handles in duplicates in a form which is not
>>>> acceptable. It will simple drop duplicates but how frame retries works is the
>> following:
>>>
>>> If your meaning for my modification is that the result will be the same
>> whether retry is enabled or not? Initially, my motivation is to prevent the
>> received retry packet from being transmitted up to the wpan-ping level, then to
>> avoid the error "Sequence number did not match".
>>>
>>
>> I looked deeper for that handling in 802.15.4-2011 (which is the version which
>> is currently free available):
>>
>> 5.1.6.6 Transmission scenarios
>>
>> Your scenario is "Lost acknowledgment frame.", I don't see anything which let
>> me accept your patch to drop multiple received frames with the same sequence
>> number. The receiving node mac802154 stack is "recipient next layer".
>>
>> Or did I miss something?
>>
>>>>
>>>> 1. Node A transmits frame for Node B with ackrequest bit set.
>>>> 2. Node B receive that frame and see's "ackrequest bit is set" and
>>>>   sending an ACK back.
>>>> 3. If Node A received an ack for the sequence number then no
>>>>   retransmission will occur.
>>>> OR
>>>> 3. If Node A doesn't received an ack it will retransmit the frame.
>>>>
>>>>
>>>> On your nodes and if you are really using two at86rf233 transceivers,
>>>> this mechanism is completely done by hardware.
>>>>
>>>> Transmit: ARET
>>>> Receive: AACK
>>>>
>>>> On the receive side it's always imporant that the receiving node
>>>> supports AACK handling if Nodes sending frames with "ackrequest bit"
>>>> set.
>>>>
>>>> ---
>>>>
>>>> First, you should sniff somehow the traffic if it's possible, to see
>>>> what's going on the traffic and you see that Node B sends ACKs back,
>>>> if not -> missing AACK handling.
>>>>
>>>> On linux the openlabs transceiver (at86rf233) supports AACK handling...
>>>> don't know if you break it with your changes.
>>>>
>>>
>>> I get it for your detailed description for frame re-transmission mechanism.
>> And yes, I really use the two at86rf233 transceivers, I also used an ieee802.15.4
>> sniffer to sniff the traffic, ackrequest bit is indeed set, and I could see the
>> captured ack.
>>>
>>> I just did some tests with the kernel v4.7 (without my duplicate modification),
>> I did 3 cases, as below and the attachment:
>>> 1. set the max_frame_retries=3 for nodeA and nodeB, lots of "Sequence
>>> number did not match" errors occur during the test 2. set the
>>> max_frame_retries=0 for nodeA, and set the max_frame_retries=3 for
>>> nodeB, lots of "Sequence number did not match" errors occur during the test
>> 3. set the max_frame_retries=3 for nodeA, and set the max_frame_retries=0 for
>> nodeB, no above error occur In my goal, the retry needs to be enabled for both
>> sides, so I'd like to know the root cause for such case.
>>> I also made a simple description for the test cases to make you clearer for my
>> problem, a few typical captured packets are shown in the attachment.
>>> Hope you could give some suggestions for the problem, thank you very much!
>>>
>>
>> Sure, retransmits can be 3 at both sides. But somehow you have a missing
>> acknowledgment frame. The sniff example shows me this was never send.
>>
>> It could be that you transmit very fast and a force state change aborts the
>> transmitting of ACK frame in RX_AACK_BUSY state.
>>
>> Can you try this:
>>
>> diff --git a/drivers/net/ieee802154/at86rf230.c
>> b/drivers/net/ieee802154/at86rf230.c
>> index 9f10da6..97f75b5 100644
>> --- a/drivers/net/ieee802154/at86rf230.c
>> +++ b/drivers/net/ieee802154/at86rf230.c
>> @@ -64,7 +64,7 @@ struct at86rf2xx_chip_data {
>>  *
>>  * We assume the max_frame_retries (7) value of 802.15.4 here.
>>  */
>> -#define AT86RF2XX_MAX_TX_RETRIES       7
>> +#define AT86RF2XX_MAX_TX_RETRIES       20
>> /* We use the recommended 5 minutes timeout to recalibrate */
>> #define AT86RF2XX_CAL_LOOP_TIMEOUT     (5 * 60 * HZ)
>>
> I tried the test, but the result is still the same, lots of errors "Sequence number did not match" occur.
> Actually, I made some modification for at86rf230.c and wpan-ping.c for our experiment. To figure out the problem, I also tried other tests:
> 1. without any modification for at86rf230.c and wpan-ping.c, and enable the max_frame_retries (3) for both sides, the error "Sequence number did not match" also occurs, but not so frequently, it goes well overall.
> 2. with my modification for at86rf230.c, without the modification for wpan-ping.c, and enable the max_frame_retries (3) for both sides, lots of errors "Sequence number did not match" will occur.
> So, I guess it may be caused by my modification to the at86rf230.c. But I cannot figure out the problem, could you help me? Thank you!
> Below shows my modification, the motivation is to try to get the mac sequence number, rssi and lqi of the received packet, and output the values into a debug file:
> 

Sorry, I have no idea. You modification could insert some additional
operation which makes something slower.

I change not my opinion, I think something will do a FORCE TX_ON
statechange, if this is going while RX_AACK_BUSY (don't know the exact
namens), then it will abort a sending of ack frame, the frame can be
received before.

You can remove the if-branch at [0] which will never make some force
state change, when we receive currently. To be clear, this patch:

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 9f10da6..d4c6d72 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -447,8 +447,6 @@ at86rf230_async_state_assert(void *context)
                            ctx->to_state == STATE_TRX_OFF) {
                                u8 state = ctx->to_state;
 
-                               if (lp->tx_retry >= AT86RF2XX_MAX_TX_RETRIES)
-                                       state = STATE_FORCE_TRX_OFF;
                                lp->tx_retry++;
 
                                at86rf230_async_state_change(lp, ctx, state,

---

I currently have no idea what's going on your side and my only one guess
is that FORCE change will abort the transmitting of an ACK frame, but I
also didn't saw some behaviour like that on my side. I also doesn't have
a two RPi2 setup.

- Alex

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L450
