Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32799 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaJMRLV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 13:11:21 -0400
Date: Mon, 13 Oct 2014 19:11:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC
 decompression.
Message-ID: <20141013171111.GA25249@omega>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>
 <543BCF44.1030001@xsilon.com>
 <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>
 <543BE816.80304@xsilon.com>
 <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Jukka,

On Mon, Oct 13, 2014 at 06:09:14PM +0300, Jukka Rissanen wrote:
> Hi Martin,
> 
> On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
> > Hi Jukka,
> > 
> > Does this patch help?
> 
> Unfortunately no, I still see inconsistent lock state. It would probably
> have been too easy :)
> 

I remeber something, I think 802.15.4 had similar issues long time ago.

The fix was 20e7c4e80dcd01dad5e6c8b32455228b8fe9c619 ("6lowpan: fix
lockdep splats"). Please check that, you need something like that!

- Alex

[0] 
