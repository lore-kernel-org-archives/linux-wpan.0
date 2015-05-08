Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33321 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbEHJlD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 05:41:03 -0400
Date: Fri, 8 May 2015 11:40:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next] mac802154: fakelb: Fix potential NULL
 pointer dereference.
Message-ID: <20150508094052.GA29865@omega>
References: <1431075430-20872-1-git-send-email-martin.townsend@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1431075430-20872-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Fri, May 08, 2015 at 09:57:10AM +0100, Martin Townsend wrote:
> fakelb_hw_deliver creates a copy of the skb's header which can
> potentially return NULL so we now check for this before actually
> delivering to the 802.15.4 MAC layer.
> 
> Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

I hope that's the correct patch now.

While reviewing I detect some issues. The ToDo's of fakelb driver are:

 - renaming the somewhat misnamed driver "fakelb"? I would ack that, but
   this isn't well to do that, but fakelb can be everything and what I
   think it's somewhat like "fakel(oop)b(ack)", but we faking wpan
   phy's with this driver.

 - use xmit_async instead xmit_sync. That should be easily, there are
   no issues which the driver is using and can't run in the xmit_async
   context.

 - add channel and page match into delivering. Currently there is
   channel only and to be correct it need to be channel AND page.
   A phy which has different page and the same channel can't transmit to
   each other. Other modulation/frequency.

 - What I suggest how this driver is working is:
   - Load the driver -> one phy will be generated
   - Over sysfs you can add more phy's
   - Then you have several virtual phy's.

   When one virtual PHY transmit a frame then all other EXCEPT the phy
   which transmitted the frame will delivering the frame when page and
   channel matches.

   But the current situation is more funny. When one phy is there then
   the same phy which transmit the frame also recevie the same frame.
   When more phy's are there then all phy's also the phy which
   transmitted the frame receive the frame. This is a wrong behaviour
   which makes no sense, it should be easily to add a check on the own
   phy when delivering the frame to all other virtual frames EXCEPT the
   own one.

 - I think the spinlock is necessary only for channel/page setting callback
   and while check on other channels/pages in delivering.

After that the fakelb is hopefully in a better state.

- Alex

