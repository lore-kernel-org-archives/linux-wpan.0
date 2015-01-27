Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:50014 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbbA0Leo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 27 Jan 2015 06:34:44 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so4110751wiv.0
        for <linux-wpan@vger.kernel.org>; Tue, 27 Jan 2015 03:34:42 -0800 (PST)
Message-ID: <54C777D0.6090608@6wind.com>
Date: Tue, 27 Jan 2015 12:34:40 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] caif: remove wrong dev_net_set() call
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <1422307694-10079-2-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1422307694-10079-2-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dmitry.tarnyagin@lockless.no, arvid.brodin@alten.se, alex.aring@gmail.com, linux-wpan@vger.kernel.org, =?UTF-8?B?U2p1ciBCcsOmbmRlbGFuZA==?= <sjur.brandeland@stericsson.com>

Le 26/01/2015 22:28, Nicolas Dichtel a écrit :
> src_net points to the netns where the netlink message has been received. This
> netns may be different from the netns where the interface is created (because
> the user may add IFLA_NET_NS_[PID|FD]). In this case, src_net is the link netns.
>
> It seems wrong to override the netns in the newlink() handler because if it
> was not already src_net, it means that the user explicitly asks to create the
> netdevice in another netns.
>
> CC: Sjur Brændeland <sjur.brandeland@stericsson.com>
> CC: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>

I got a "Delivery Status Notification (Failure)" for Dmitry Tarnyagin (I took 
the email address from the MAINTAINERS file):

   Delivery to the following recipient failed permanently:

        dmitry.tarnyagin@lockless.no

   Technical details of permanent failure:
   Google tried to deliver your message, but it was rejected by the server for
   the recipient domain lockless.no by mail.lockless.no. [46.29.221.38].

   The error that the other server returned was:
   550 5.1.1 <dmitry.tarnyagin@lockless.no>: Recipient address rejected: User
   unknown in virtual mailbox table

Any suggestions?
