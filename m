Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61440 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbaIWH6M (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 03:58:12 -0400
Message-ID: <5421280E.2060203@xsilon.com>
Date: Tue, 23 Sep 2014 08:58:06 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com> <20140916070156.GB1244@omega> <541899D8.4020101@componentsw.com> <20140916202000.GF6104@omega> <5420EE4F.5000007@signal11.us> <20140923071932.GA11396@omega>
In-Reply-To: <20140923071932.GA11396@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>
Cc: Walter Mack <wmack@componentsw.com>, linux-wpan@vger.kernel.org

I was under the impression the patch had been signed off. Maybe I missed 
a mail...
I can confirm the mrf24j40 works just fine using a DT.

Simon

On 23/09/14 08:19, Alexander Aring wrote:
> Hi,
>
> On Mon, Sep 22, 2014 at 11:51:43PM -0400, Alan Ott wrote:
>> On 09/16/2014 04:20 PM, Alexander Aring wrote:
>>> Hi Walter,
>>>
>>> On Tue, Sep 16, 2014 at 01:13:12PM -0700, Walter Mack wrote:
>>>> Alex,
>>>>
>>>> this is not a question of chip revisions. Chips with the same revision can
>>>> be used in designs with or without the external transmitter/receiver. Its
>>>> just that the chip has to be set up to be compatible with the design.
>>>>
>>> ah, ok. Dunno, I will wait on alan's opinion. If I don't heard anything in one
>>> week I will apply it.
>> Did Simon's patch get applied? I couldn't see it in any of the obvious
>> places when I looked the other day.
>>
> no, I finally wait for your Acked-by: .... otherwise I will not apply.
> That's indicate for me that this patch is okay for you and came into
> mainline. There are also pending patches from Varka, if you don't reply
> on it, I will not apply it. Should I always simple apply the patches
> if you don't response? It's better for me that I see a "Acked-by" from you.
>
> Simon's patch state:
> You had some reviewing notes at Simon's patch. I think Simon doesn't
> response to this yet. I didn't see any new versions of this.
>
>
>
> For DT example you can take a look into at86rf230 driver or cc2520. I
> mean examples to add some DT properties. Also if you want to make this
> driver dt enabled then you need a documentation in:
>
> Documentation/devicetree/bindings/net/ieee802154/$DRIVERNAME.txt
>
>
> - Alex

