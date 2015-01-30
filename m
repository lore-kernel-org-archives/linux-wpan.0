Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from spam1.webland.se ([91.207.112.90]:56923 "EHLO spam1.webland.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978AbbA3UFc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 30 Jan 2015 15:05:32 -0500
Message-ID: <54CBE2EF.7050003@alten.se>
Date: Fri, 30 Jan 2015 21:00:47 +0100
From: Arvid Brodin <arvid.brodin@alten.se>
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dmitry.tarnyagin@lockless.no, alex.aring@gmail.com, linux-wpan@vger.kernel.org

On 2015-01-26 22:28, Nicolas Dichtel wrote:
*snip*
> - HSR subsystem uses src_net to parse IFLA_HSR_SLAVE[1|2], but the netdevice has
>   the flag NETIF_F_NETNS_LOCAL, so the question is: does this netdevice really
>   supports x-netns? If not, the newlink handler should use the dest_net instead
>   of src_net, I can provide the patch.
*snip*

As the author of the HSR driver, I'd like to answer this question, but unfortunately 
I don't know what x-netns is. Neither Google nor Documentation/ has been particularly
helpful.

Care to elaborate? (Maybe this is a moot point now that the patch has been accepted,
but I'd still like to understand, if you have the time to explain.)

(Pretty much all I know about network namespaces is from this article: 
http://lwn.net/Articles/580893/.)


-- 
Arvid Brodin | Consultant (Linux)
ALTEN | Knarrarnäsgatan 7 | SE-164 40 Kista | Sweden
arvid.brodin@alten.se | www.alten.se/en/
