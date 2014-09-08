Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38409 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbaIHKkO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Sep 2014 06:40:14 -0400
Date: Mon, 8 Sep 2014 12:40:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
Message-ID: <20140908104008.GB6981@omega>
References: <53DCE75C.2030305@xsilon.com>
 <20140821083945.GA29484@omega>
 <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
 <53FE446D.6040805@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53FE446D.6040805@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Martin,

On Wed, Aug 27, 2014 at 09:49:49PM +0100, Martin Townsend wrote:
> On 21/08/14 14:24, Marcel Holtmann wrote:
> >Hi Alex,
> >
> >>this patch wasn't able to apply and now it doesn't apply either (because
> >>lot of other changes). I thought you will resend a v3 and then I will
> >>care about reviewing. Then putting Acked-by, then Marcel will put it on
> >>the right repositories.
> >>
> >>If you can, describe the changes in the commit msg (please note the 80
> >>line width there).
> >>
> >>This patch is also something for bluetooth (not bluetooth-next), it's a
> >>bug fix. But this depends how Marcel will dealing with this issue. It's
> >>a bugfix with a huge change of lines. I would base it on bluetooth,
> >>because it's a bug fix.
> >simplifying something is not for -stable or a bug fix. If there is a memory leak, then fix that memory leak first in a separate patch. The rules are pretty clear here. Only bug fixes after the merge window has closed.
> >
> >Regards
> >
> >Marcel
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Hi,
> 
> I'll respin and include the memory leak fix and this patch and a couple of
> others I have and send as a series to bluetooth.  What bluetooth git
> repository should I base the series on?
> 

What's the state about to fix this bad issue? :-)

I didn't saw any new patches because of this.

- Alex
