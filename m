Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49590 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaHUIkH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 Aug 2014 04:40:07 -0400
Date: Thu, 21 Aug 2014 10:39:47 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] Simplify lowpan receive path so skb is
 freed in lowpan_rcv when dropped.
Message-ID: <20140821083945.GA29484@omega>
References: <53DCE75C.2030305@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53DCE75C.2030305@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>

Hi Martin,

this patch wasn't able to apply and now it doesn't apply either (because
lot of other changes). I thought you will resend a v3 and then I will
care about reviewing. Then putting Acked-by, then Marcel will put it on
the right repositories.

If you can, describe the changes in the commit msg (please note the 80
line width there).

This patch is also something for bluetooth (not bluetooth-next), it's a
bug fix. But this depends how Marcel will dealing with this issue. It's
a bugfix with a huge change of lines. I would base it on bluetooth,
because it's a bug fix.

- Alex
