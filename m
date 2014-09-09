Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58204 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaIII7S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Sep 2014 04:59:18 -0400
Message-ID: <540EC162.7060604@xsilon.com>
Date: Tue, 09 Sep 2014 09:59:14 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb
 is freed in lowpan_rcv when dropped.
References: <53DCE75C.2030305@xsilon.com> <20140821083945.GA29484@omega> <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org> <53FE446D.6040805@xsilon.com> <20140908104008.GB6981@omega> <540DF1AE.2070709@xsilon.com> <20140908183652.GA633@omega>
In-Reply-To: <20140908183652.GA633@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Alex,

On 08/09/14 19:36, Alexander Aring wrote:
> Hi Martin,
>
> On Mon, Sep 08, 2014 at 07:13:02PM +0100, Martin Townsend wrote:
> ...
>>>> Hi,
>>>>
>>>> I'll respin and include the memory leak fix and this patch and a couple of
>>>> others I have and send as a series to bluetooth.  What bluetooth git
>>>> repository should I base the series on?
>>>>
>>> What's the state about to fix this bad issue? :-)
>>>
>>> I didn't saw any new patches because of this.
>>>
>>> - Alex
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Sorry for the delay, been on hols for a few days, I will create the patches
>> tomorrow if I get time.
>>
>> I have also implemented Generic Header Compression[0] which is still in
>> draft at the moment but I can't imagine it will change much before being
>> released.  I'm going to integrate it into our linux repository this week.
>> Would you be interested in putting it in linux-wpan or linux-wpan-next or
>> would you prefer to wait until it gets it RFC status?
>>
> no, for me it's okay to have this mainline. I heard that a draft becomes
> no RFC when nobody implements it.
>
> But another point, I want to avoid that everything is putted into the
> iphc file for next header compression. Did you saw the patches for the
> next header compression layer?
yes I did and would like to add GHC to this new framework so will wait until it's included.
>
> This is a layer to separate next header implementation, like IPv6 it
> does for next header [0]. [0] shows the registration of the next header
> protocols.
>
> We should have something similar and I post some months a RFC about
> that. I got some review notes and need to rework it, working branch is
> at [1].
>
> Also I added that we drop packets for IPv6 Header Extensions, described
> at [2]. We currently no support this kind of next header compression and
> if we don't check on it, we send garbage to IPv6 layer. (That's of
> course one more argument to implement draft next header compression
> formats).
>
>
> For now, we should make it like this:
>
> - First you send patches for the fixes.
> - Then I will send patches for the nhc layer.
> - You send patches to adding the your next header compression formats.
>   based on the nhc layer.
>
> Is that okay for you? It should easily for you to add your header compression
> formats. (Filling some struct with macro and implement some callbacks).
ok for me.
>
> This is all related stuff to the GENERIC 6LOWPAN branch, all which
> belongs to IPHC and IPHC contains next header compression. As
> conclusion this should be go to bluetooth/bluetooth-next.
>
> Bug fixes to bluetooth, new features to bluetooth-next.
>
ok.
>
> btw:
> I working on the 802.15.4 rework. I am sure you know that I want to make
> a rework of the 802.15.4 stack. Very busy at the moment, but this should
> not affect the net/6lowpan branch. Only the net/ieee802.15.4/6lowpan.
>
> I will take some time, so after you send fixes for this I will rebase/rework
> the nhc layer patches to try to bring it mainline. Then you can make your work
> on it.
ok.
>
> - Alex
>
> [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/af_inet6.c?id=refs/tags/v3.17-rc4#n822
> [1] https://github.com/linux-wpan/linux-wpan-next/tree/nhc_layer
> [2] http://tools.ietf.org/html/rfc6282#section-4.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

