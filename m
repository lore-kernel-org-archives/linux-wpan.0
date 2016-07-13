Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34667 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbcGMKN5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Jul 2016 06:13:57 -0400
MIME-Version: 1.0
In-Reply-To: <9025f3ab-9b4d-5120-d078-35b6df5b8beb@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de> <CABBYNZJFStOf6qOcpP6DmdxFBx7swrnFPmQLizy0UyokwS64ng@mail.gmail.com>
 <5b41b0e5-c017-20d9-c94f-11fb1ab2847d@pengutronix.de> <9025f3ab-9b4d-5120-d078-35b6df5b8beb@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Jul 2016 13:13:54 +0300
Message-ID: <CABBYNZJKzwJf_dRgLwPbRnZccutkXPcAoj7R2HYMhKTp4HCBhQ@mail.gmail.com>
Subject: Re: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan implementation
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>

Hi Alex,

On Wed, Jul 13, 2016 at 12:12 PM, Alexander Aring <aar@pengutronix.de> wrote:
>
> Hi,
>
> On 07/12/2016 08:35 PM, Alexander Aring wrote:
>>
>> Hi,
>>
>> On 07/12/2016 04:51 PM, Luiz Augusto von Dentz wrote:
>> ...
>>>>
>>>> HOW TO REPRODUCE:
>>>>
>>>> It's simple, do some high payloads which makes lot tx/rcv traffic on both sides:
>>>>
>>>> Node A:
>>>>
>>>>  ping6 $IP_NODEB%6lo0 -s 60000
>>>>
>>>> Node B:
>>>>
>>>>  ping6 ff02::1%6lo0
>>>
>>> Im not sure I understand what you are trying to do with a packet of
>>> 60Kb, the l2cap_chan can most likely only do 1280 bytes and even with
>>
>> 60Kb is just some incredible high value to produce on both sides tx/rx
>> data. The other side will normally send some "defragmentation failure"
>> icmp messages.
>>
>> This value is just to produce the high traffic, not practice payload.
>>
>>> fragmentation this will consume the credits quicker than we can
>>> receive more so it will eventually starting buffering until it gets
>>> stuck. Note that it is probably still receiving credits but we
>>
>> This is exactly what I like to do. Produce a lot of data to kill L3
>> layer, but this should not kill the L2 layer. Killing the L2 layer is
>> what's happend here.
>>
>> If I do a lot of data on e.g. tcp traffic and the tcp connection will be
>> closed -> that's fine for me but afterwards starting a new L3 connection
>> should be still working. This is not the case here, I can kill L2 layer
>> and nothing works anymore, because L2 running into deadlock.
>>
>>> probably have so much data buffered that all the credits are consumed
>>> almost immediately after receiving, or you don't see -EAGAIN more than
>>> once?
>>>
>>
>> My example shows that we transmit some data on both nodes, that is
>> important to check the l2cap_chan_send return type.
>>
>> When I do that above and running into the deadlock the IPv6 connection
>> runs "NS" messages only, because it still can send on L3 layer but the
>> L2 layer is killed -> I get -EAGAIN in l2cap_chan_send always on both
>> nodes because tx_credits are on both nodes zero and will not be
>> incremented again.
>>
>> So far I know these tx_credits will be incremented only if somebody
>> sends something again, right? This will never be the case again and I am
>> stucked in a deadlock which should not be there.
>>
>> to your question:
>>
>> "or you don't see -EAGAIN more than once"
>>
>> I see -EAGAIN always at calling l2cap_chan_send on both nodes. I think I
>> can wait forever, after an year I still see "-EAGAIN" when calling
>> l2cap_chan_send.
>>
>> Nevertheless, I will try to hit the deadlock (-EAGAIN) on both nodes so
>> nobody transmits anything anymore. Then waiting six hours and look if
>> still -EAGAIN is there on both nodes. I will report again here, after
>> that time it should working again, but I don't believe that.
>>
>
> I waited about ~ 6hours, deadlock was still there.
>
> Node A:
>
> transmit return value -11
> send 6lo0 failed chan f617cc00
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
> transmit return value -11
> send 6lo0 failed chan f617cc00
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
> transmit return value -11
> send 6lo0 failed chan f617cc00
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
> transmit return value -11
> send 6lo0 failed chan f617cc00
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:68:c1:76
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:6b:3b:1f type 1 src: 5c:f3:70:68:c1:76 chan f617cc00
> transmit return value -11
> send 6lo0 failed chan f617cc00
>
> Node B:
>
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:6b:3b:1f
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:68:c1:76 type 1 src: 5c:f3:70:6b:3b:1f chan f62aac00
> transmit return value -11
> send 6lo0 failed chan f62aac00
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:6b:3b:1f
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:68:c1:76 type 1 src: 5c:f3:70:6b:3b:1f chan f62aac00
> transmit return value -11
> send 6lo0 failed chan f62aac00
> xmit ndisc 6lo0 dst: ff:ff:ff:ff:ff:ff src: 5c:f3:70:6b:3b:1f
> xmit 6lo0 starts multicasting
> l2cap_chan_send 6lo0 dst: 5c:f3:70:68:c1:76 type 1 src: 5c:f3:70:6b:3b:1f chan f62aac00
> transmit return value -11
> send 6lo0 failed chan f62aac00

Are there any calls to channel resume?

> ---
>
> They simple show the same stuff, but with different addresses.
>
> I rethink about your words and I suppose you told me that tx_credits and
> -EAGAIN are normal that this stuff occurs.
>
> I agree, It also occurs before when I run:
>
> ping6 $IP_NODEB%6lo0 -s 60000
>
> which is normal. But what should not happen is that there is some little
> tiny window (race) that both tx_credits are reached to zero and then
> nobody transmit anything anymore, that's the tx deadlock which I hit here.
>
> And this deadlock occurs that I killed the L2CAP chan connection. I
> think it will work when I create a new chan (because new tx_credits).
> The connection isn't broken, I just can not transmit anything because tx_credits.

If there is no calls to channel resume then yes there is a problem
that no tx_credits would be able to be sent, note though that the
command the restore credits does happen in the signalling channel not
in the data channel so there should be anything blocking from
receiving those, perhaps looking into what is happening the last time
it receives credits and the sequence of calls it generate.


-- 
Luiz Augusto von Dentz
