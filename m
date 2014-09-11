Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:49795 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbaIKOKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Sep 2014 10:10:54 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH][linux-bluetooth 2/3] 6lowpan: Move skb delivery from IPHC.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140911081808.GA19675@omega>
Date: Thu, 11 Sep 2014 07:11:31 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <1C268090-606B-45BF-8B47-7A3B35886F10@holtmann.org>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com> <1410357968-27051-4-git-send-email-martin.townsend@xsilon.com> <20140911081808.GA19675@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Martin Townsend <martin.townsend@xsilon.com>

Hi Alex,

>> Passing the skb from 6lowpan up to the higher layers is not a
>> function of IPHC.  By moving it out of IPHC we also remove the
>> need to support error code returns with NET_RX codes.
>> It also makes the lowpan_rcv function more extendable as we
>> can support more compression schemes.
>> 
> 
> I will ack this. But please sperate this patch in two. First renaming
> the function namens and then removing deliver callback.
> 
> btw. The correct tag is bluetooth not linux-bluetooth, or bluetooth-next.
> 
> 
> 
> Also this doesn't fix anything? Then this is for bluetooth-next. I know
> this depends on the Patch 1/3. Marcel, do you have any a nice solution
> about this, that we can deal with huge fixes in bluetooth and new features
> for bluetooth-next. Or simple wait when it's merged?

we need to get it into wireless first and pulled by davem. After that I can ask John to pull wireless tree back into wireless-next.

Regards

Marcel

