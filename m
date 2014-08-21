Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:50750 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbaHUNY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 Aug 2014 09:24:27 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is freed in lowpan_rcv when dropped.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140821083945.GA29484@omega>
Date: Thu, 21 Aug 2014 08:24:15 -0500
Content-Transfer-Encoding: 8BIT
Message-Id: <3DF0C18C-4A97-4A00-AB0F-9E01F72CE967@holtmann.org>
References: <53DCE75C.2030305@xsilon.com> <20140821083945.GA29484@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Alex,

> this patch wasn't able to apply and now it doesn't apply either (because
> lot of other changes). I thought you will resend a v3 and then I will
> care about reviewing. Then putting Acked-by, then Marcel will put it on
> the right repositories.
> 
> If you can, describe the changes in the commit msg (please note the 80
> line width there).
> 
> This patch is also something for bluetooth (not bluetooth-next), it's a
> bug fix. But this depends how Marcel will dealing with this issue. It's
> a bugfix with a huge change of lines. I would base it on bluetooth,
> because it's a bug fix.

simplifying something is not for -stable or a bug fix. If there is a memory leak, then fix that memory leak first in a separate patch. The rules are pretty clear here. Only bug fixes after the merge window has closed.

Regards

Marcel

