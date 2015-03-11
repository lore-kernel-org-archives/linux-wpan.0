Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44708 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbCKSRP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Mar 2015 14:17:15 -0400
Date: Wed, 11 Mar 2015 19:17:04 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 13/15] ieee802154: don't export static symbol
Message-ID: <20150311181700.GA23342@omega>
References: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
 <1426092997-30605-14-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426092997-30605-14-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@iogearbox.net, marcel@holtmann.org

On Wed, Mar 11, 2015 at 05:56:35PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> type T;
> identifier f;
> @@
> 
> static T f (...) { ... }
> 
> @@
> identifier r.f;
> declarer name EXPORT_SYMBOL;
> @@
> 
> -EXPORT_SYMBOL(f);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Alexander Aring <alex.aring@gmail.com>

Marcel can you please queue this into bluetooth-next, or even bluetooth?

Thanks.

- Alex
