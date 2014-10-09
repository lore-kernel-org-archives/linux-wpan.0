Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11788 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbaJIHSz (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 9 Oct 2014 03:18:55 -0400
Message-ID: <1412839130.2705.35.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v4 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 09 Oct 2014 10:18:50 +0300
In-Reply-To: <5435589A.7050605@xsilon.com>
References: <1412776015-372-1-git-send-email-martin.townsend@xsilon.com>
	 <1412776015-372-2-git-send-email-martin.townsend@xsilon.com>
	 <20141008145917.GA23456@omega> <543553AD.9000501@xsilon.com>
	 <20141008152750.GB23456@omega> <5435589A.7050605@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Martin,

code is ok by me.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


On ke, 2014-10-08 at 16:30 +0100, Martin Townsend wrote:
> Hi Alex,
> 
> I'll wait for Jukka's ack for the bluetooth side and then send v5 with the removed skb_share_check.
> 
> - Martin.
> 


Cheers,
Jukka


