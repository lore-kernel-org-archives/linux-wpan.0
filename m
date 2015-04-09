Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34456 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbbDIMGC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 08:06:02 -0400
Received: by widjs5 with SMTP id js5so53683967wid.1
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 05:06:00 -0700 (PDT)
Date: Thu, 9 Apr 2015 14:05:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] mac802154: add description to mac802154 APIs
Message-ID: <20150409120556.GH1261@omega>
References: <1428571921-2999-1-git-send-email-varkab@cdac.in>
 <20150409115319.GG1261@omega>
 <552668E3.7060600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <552668E3.7060600@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Thu, Apr 09, 2015 at 05:26:19PM +0530, Varka Bhadram wrote:
> On 04/09/2015 05:23 PM, Alexander Aring wrote:
> > On Thu, Apr 09, 2015 at 03:02:01PM +0530, Varka Bhadram wrote:
> >> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> >> ---
> >>  include/net/mac802154.h |   95 ++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 93 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> >> index e18e7fd..474dafb 100644
> >> --- a/include/net/mac802154.h
> >> +++ b/include/net/mac802154.h
> >> @@ -247,19 +247,110 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
> >>  	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
> >>  }
> >>  
> >> -/* Basic interface to register ieee802154 device */
> >> +/**
> >> + * ieee802154_alloc_hw - Allocate a new hardware device
> >> + *
> >> + * This must be called once for each hardware device. The returned pointer
> >> + * must be used to refer to this device when calling other functions.
> >> + * mac802154 allocates a private data area for the driver pointed to by
> >> + * @priv in &struct ieee802154_hw, the size of this area is given as
> >> + * @priv_data_len.
> >> + *
> >> + * @priv_data_len: length of private data
> >> + * @ops: callbacks for this device
> >> + *
> >> + * Return: A pointer to the new hardware device, or %NULL on error.
> >> + */
> >>  struct ieee802154_hw *
> >>  ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);
> >> +
> >> +/**
> >> + * ieee802154_free_hw - free hardware descriptor
> >> + *
> >> + * This function frees everything that was allocated, including the
> >> + * private data for the driver. You must call ieee802154_unregister_hw()
> >> + * before calling this function.
> >> + *
> >> + * @hw: the hardware to free
> >> + */
> >>  void ieee802154_free_hw(struct ieee802154_hw *hw);
> >> +
> >> +/**
> >> + * ieee802154_register_hw - Register hardware device
> >> + *
> >> + * You must call this function before any other functions in
> >> + * mac802154. Note that before a hardware can be registered, you
> >> + * need to fill the contained wpan_phy's information.
> >> + *
> >> + * @hw: the device to register as returned by ieee802154_alloc_hw()
> >> + *
> >> + * Return: 0 on success. An error code otherwise.
> >> + */
> >>  int ieee802154_register_hw(struct ieee802154_hw *hw);
> >> +
> >> +/**
> >> + * ieee802154_unregister_hw - Unregister a hardware device
> >> + *
> >> + * This function instructs mac802154 to free allocated resources
> >> + * and unregister netdevices from the networking subsystem.
> >> + *
> >> + * @hw: the hardware to unregister
> >> + */
> >>  void ieee802154_unregister_hw(struct ieee802154_hw *hw);
> >>  
> >> +/**
> >> + * ieee802154_rx - receive frame
> >> + *
> >> + * Use this function to hand received frames to mac802154. The receive
> >> + * buffer in @skb must start with an IEEE 802.15.4 header. In case of a
> >> + * paged @skb is used, the driver is recommended to put the ieee802154
> >> + * header of the frame on the linear part of the @skb to avoid memory
> >> + * allocation and/or memcpy by the stack.
> >> + *
> >> + * This function may not be called in IRQ context. Calls to this function
> >> + * for a single hardware must be synchronized against each other.
> >> + *
> >> + * @hw: the hardware this frame came in on
> >> + * @skb: the buffer to receive, owned by mac802154 after this call
> >> + */
> >>  void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb);
> >> +
> >> +/**
> >> + * ieee802154_rx_irqsafe - receive frame
> >> + *
> >> + * Like ieee802154_rx() but can be called in IRQ context
> >> + * (internally defers to a tasklet.)
> >> + *
> >> + * @hw: the hardware this frame came in on
> >> + * @skb: the buffer to receive, owned by mac802154 after this call
> > missing lqi param description.
> 
> will do.
> 
> >> + */
> >>  void ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb,
> >>  			   u8 lqi);
> >> -
> >> +/**
> >> + * ieee802154_wake_queue - wake specific queue
> >> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> >> + * @queue: queue number (counted from zero).
> >> + *
> > which specific queue? This have wireless only.
> 
> wake wireless queue.... Is OK? 
> 
> What do you suggest?

We don't have a queue parameter for this function. This is a copy&paste
issue from wireless code.

> 
> >> + * Drivers should use this function instead of netif_wake_queue.
> >> + */
> >>  void ieee802154_wake_queue(struct ieee802154_hw *hw);
> >> +
> >> +/**
> >> + * ieee802154_stop_queue - stop specific queue
> >> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> >> + * @queue: queue number (counted from zero).
> >> + *
> > same here, we have no fancy multiple queues.
> 
> What do you suggest?
> 

Same here.

> >> + * Drivers should use this function instead of netif_stop_queue.
> >> + */
> >>  void ieee802154_stop_queue(struct ieee802154_hw *hw);
> >> +
> >> +/**
> >> + * ieee802154_xmit_complete - packet transmission complete
> >> + *
> >> + * @hw: pointer as obtained from ieee802154_alloc_hw().
> >> + * @skb: buffer for transmission
> >> + * @ifs_handling: indicate interframe space handling
> >> + */
> >>  void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
> >>  			      bool ifs_handling);

- Alex
