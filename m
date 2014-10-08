Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:42895 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbaJHILD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 04:11:03 -0400
Date: Wed, 8 Oct 2014 10:10:54 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141008081052.GA15625@omega>
References: <1412753745-6469-1-git-send-email-martin.townsend@xsilon.com>
 <1412753745-6469-2-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412753745-6469-2-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

On Wed, Oct 08, 2014 at 08:35:45AM +0100, Martin Townsend wrote:
> Currently there are potentially 2 skb_copy_expand calls in IPHC
> decompression.  This patch replaces this with one call to
> pskb_expand_head.  It also checks to see if there is enough headroom
> first to ensure it's only done if necessary.
> As pskb_expand_head must only have one reference the calling code
> now ensures this.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>
