Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38006 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaIXJu6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 05:50:58 -0400
Received: by mail-wi0-f177.google.com with SMTP id q5so6854926wiv.16
        for <linux-wpan@vger.kernel.org>; Wed, 24 Sep 2014 02:50:57 -0700 (PDT)
Date: Wed, 24 Sep 2014 11:50:50 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140924095049.GA5246@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com, marcel@holtmann.org

Hi Simon,

On Mon, Sep 22, 2014 at 04:52:03PM +0100, Simon Vincent wrote:
> The 6lowpan ipv6 header compression was causing problems for other interfaces
> that expected a ipv6 header to still be in place, as we were replacing the
> ipv6 header with a compressed version. This happened if you sent a packet to a
> multicast address as the packet would be output on 802.15.4, ethernet, and also
> be sent to the loopback interface. The skb data was shared between these
> interfaces so all interfaces ended up with a compressed ipv6 header.
> The solution is to ensure that before we do any header compression we are not
> sharing the skb or skb data with any other interface. If we are then we must
> take a copy of the skb and skb data before modifying the ipv6 header.
> The only place we can copy the skb is inside the xmit function so we don't
> leave dangling references to skb.
> This patch moves all the header compression to inside the xmit function. Very
> little code has been changed it has mostly been moved from lowpan_header_create
> to lowpan_xmit. At the top of the xmit function we now check if the skb is
> shared and if so copy it. In lowpan_header_create all we do now is store the
> source and destination addresses for use later when we compress the header.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>

patch has been applied to linux-wpan-next/testing.

Minor changes "__le16 mode" to "u8 mode".

Thanks for your effort to pointing this issue out.

- Alex
