Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:56394 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeCVPPB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Mar 2018 11:15:01 -0400
Date: Thu, 22 Mar 2018 11:14:59 -0400 (EDT)
Message-Id: <20180322.111459.572078630003511841.davem@davemloft.net>
Subject: Re: [PATCH net-next 2/2] net: Convert nf_ct_net_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <152145994646.26348.3106975491506950180.stgit@localhost.localdomain>
References: <152145973147.26348.4080298027358158796.stgit@localhost.localdomain>
        <152145994646.26348.3106975491506950180.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: ktkhai@virtuozzo.com
Cc: alex.aring@gmail.com, stefan@osg.samsung.com, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, yoshfuji@linux-ipv6.org, brouer@redhat.com, keescook@chromium.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:45:46 +0300

> These pernet_operations register and unregister sysctl.
> Also, there is inet_frags_exit_net() called in exit method,
> which has to be safe after a560002437d3 "net: Fix hlist
> corruptions in inet_evict_bucket()".
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Applied.
