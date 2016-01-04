Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33836 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcADOd5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 Jan 2016 09:33:57 -0500
Date: Mon, 4 Jan 2016 15:33:49 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] mac802154: constify ieee802154_llsec_ops structure
Message-ID: <20160104143344.GA18317@omega>
References: <1450906592-9203-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450906592-9203-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, marcel@holtmann.org

Hi,

On Wed, Dec 23, 2015 at 10:36:32PM +0100, Julia Lawall wrote:
> The ieee802154_llsec_ops structure is never modified, so declare it as
> const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

Acked-by: Alexander Aring <alex.aring@gmail.com>

Marcel, can you please apply this on bluetooth-next?

Thank you.

- Alex
