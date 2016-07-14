Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35416 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcGNMCs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Jul 2016 08:02:48 -0400
MIME-Version: 1.0
In-Reply-To: <bfd7834e-8f1c-32d4-bf1c-aabacbf1a040@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de> <CABBYNZJFStOf6qOcpP6DmdxFBx7swrnFPmQLizy0UyokwS64ng@mail.gmail.com>
 <5b41b0e5-c017-20d9-c94f-11fb1ab2847d@pengutronix.de> <9025f3ab-9b4d-5120-d078-35b6df5b8beb@pengutronix.de>
 <CABBYNZJKzwJf_dRgLwPbRnZccutkXPcAoj7R2HYMhKTp4HCBhQ@mail.gmail.com> <bfd7834e-8f1c-32d4-bf1c-aabacbf1a040@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Jul 2016 15:02:44 +0300
Message-ID: <CABBYNZKPKqZaw=W1FMEvH_giPHafk1xUXHBG+jpt30rMCtjoPw@mail.gmail.com>
Subject: Re: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan implementation
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, kaspar@schleiser.de, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Patrik Flykt <Patrik.Flykt@linux.intel.com>

Hi Alex,

On Wed, Jul 13, 2016 at 1:56 PM, Alexander Aring <aar@pengutronix.de> wrote:

Just use a pastbin url to past the logs, that is probably not many
people interested in that.

>>> ---
>>>
>>> They simple show the same stuff, but with different addresses.
>>>
>>> I rethink about your words and I suppose you told me that tx_credits and
>>> -EAGAIN are normal that this stuff occurs.
>>>
>>> I agree, It also occurs before when I run:
>>>
>>> ping6 $IP_NODEB%6lo0 -s 60000
>>>
>>> which is normal. But what should not happen is that there is some little
>>> tiny window (race) that both tx_credits are reached to zero and then
>>> nobody transmit anything anymore, that's the tx deadlock which I hit here.
>>>
>>> And this deadlock occurs that I killed the L2CAP chan connection. I
>>> think it will work when I create a new chan (because new tx_credits).
>>> The connection isn't broken, I just can not transmit anything because tx_credits.
>>
>> If there is no calls to channel resume then yes there is a problem
>> that no tx_credits would be able to be sent, note though that the
>> command the restore credits does happen in the signalling channel not
>> in the data channel so there should be anything blocking from
>
> So these are complete separate transmission? Could it be that, because I
> do much things on the air that such "tx_credits command" stuff could not
> be reached to the other side? Then the complete mechanism can not be
> working and maybe need some recovery if no "tx_credits command reached"
> some time ago to solve this deadlock?

Well the only information about the credits I have is the rx, which is
in fact not 0 as assumed before:

rx_credits 8 -> 7

So we didn't even have to restore anything so most likely it is just
the tx_credits that goes to 0 which means there is probably a problem
with the other box.

> I am not a bluetooth expert, maybe there exists nicer solutions. :-)
>
>> receiving those, perhaps looking into what is happening the last time
>> it receives credits and the sequence of calls it generate.
>>
>
> See above, I hope that helps.

How about l2cap_le_credits, or is that not called even once? Btw, use
btmon -w <file> and just attach the file next time.

-- 
Luiz Augusto von Dentz
