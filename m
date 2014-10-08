Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34829 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaJHP15 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 11:27:57 -0400
Date: Wed, 8 Oct 2014 17:27:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141008152750.GB23456@omega>
References: <1412776015-372-1-git-send-email-martin.townsend@xsilon.com>
 <1412776015-372-2-git-send-email-martin.townsend@xsilon.com>
 <20141008145917.GA23456@omega>
 <543553AD.9000501@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <543553AD.9000501@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

On Wed, Oct 08, 2014 at 04:09:33PM +0100, Martin Townsend wrote:
> Hi  Alex,
> 
> I completely missed it, unless reassembly can result in a shared skb? can you confirm that it doesn't then I'll remove the line.
> 

No, we manipulate the skb data there. We fetch the fragment header.
See [0].

This require a unshared buffer between af_802154 and 6lowpan. Also on
LOWPAN_DISPATCH_IPV6 we fetch the one byte dispatch value.

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/reassembly.c#L328
