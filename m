Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53107 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756896AbbEVMsQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 May 2015 08:48:16 -0400
Message-ID: <555F258C.70206@osg.samsung.com>
Date: Fri, 22 May 2015 14:48:12 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/4] mac802154: remove pib lock
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com> <1432285031-3360-3-git-send-email-alex.aring@gmail.com> <555F1EB9.2070206@osg.samsung.com> <20150522124128.GB748@omega>
In-Reply-To: <20150522124128.GB748@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hello.

On 22/05/15 14:41, Alexander Aring wrote:
> On Fri, May 22, 2015 at 02:19:05PM +0200, Stefan Schmidt wrote:
>
> ...
>
>>>   	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
>>>   		rc = drv_set_promiscuous_mode(local,
>>>   					      wpan_dev->promiscuous_mode);
>>> @@ -295,11 +292,7 @@ static int mac802154_wpan_open(struct net_device *dev)
>>>   			goto out;
>>>   	}
>>> -	mutex_unlock(&phy->pib_lock);
>>> -	return 0;
>> Hmm, why did you remove the return 0; here? Is this supposed to fall through
>> to out: and use the return rc now?
>>
> This function is the netdev open call of an wpan interface. In this call
> we do at the moment all MAC dependent settings which are done by phy.
> e.g. address filtering, frame reties, etc...
>
> When this call failed the interface is still down. This callback is
> usually called on an ifup. If it's successful it's up, if not still down.
>
> The last call is:
>
>          if (local->hw.flags & IEEE802154_HW_FRAME_RETRIES) {
>                  rc = drv_set_max_frame_retries(local, wpan_dev->frame_retries);
>                  if (rc < 0)
>                          goto out;
>          }
>
> Which is the driver callback which have an identically return value
> indicator, means -ERRNO if failed, according to the netdev open call.
>
>
> We can still use the return 0 on successful or the rc. It's a silent
> cleanup which I did here (hope that was okay).
OK, so this change does not change the return value in any condition. 
That was the part I was worried about.

A silent cleanup is fine but it made me suspicious during the review. :)

>
> btw:
> Also I don't know why there is a pib hold, when some of them are mib
> attributes. This all makes no sense for me.
>
> To hold the pib_lock will represent the documentation of driver_ops, but
> this makes no sense when you hold the pib lock for mib attributes in
> this case of callback and when accessing mib attributes over netlink or
> such else to hold the mib lock and not the pib lock, something is wrong
> there.
>
> Now, we doing everything over rtnl, which can be indicated by [0] flag
> to hold this lock while netlink command and the _most_ mib attributes are
> readonly while interface up. This will occur that we need don't care
> about locking if the interface is up. For attributes like address
> filtering this is also "impossible" to set address filtering registers
> while the interface is running. The best option here is to set address
> filtering while ifup and then don't allo the change the addresses while
> having the interface up. This is what we have now.
>
>
> The dsn/bsn values are special here, this need to be writeable while ifup.
> Also we need to think about handling setting of short_address while
> assoc with coordinators, but I think this will take some time to support
> such feature. I am sure we will find some solution.

Yeah, we need to revive the coordinator functionality at all for this to 
be a problem. :)

With the above explained you can add my:

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
