Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:56778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQ1m (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Feb 2019 11:27:42 -0500
Date: Tue, 26 Feb 2019 08:27:39 -0800 (PST)
Message-Id: <20190226.082739.514572613376216886.davem@davemloft.net>
Subject: Re: [PATCH net-next] net: remove unused struct
 inet_frag_queue.fragments field
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190226014346.77719-1-posk@google.com>
References: <20190226014346.77719-1-posk@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: posk@google.com
Cc: netdev@vger.kernel.org, posk@posk.io, linux-wpan@vger.kernel.org

From: Peter Oskolkov <posk@google.com>
Date: Mon, 25 Feb 2019 17:43:46 -0800

> Now that all users of struct inet_frag_queue have been converted
> to use 'rb_fragments', remove the unused 'fragments' field.
> 
> Build with `make allyesconfig` succeeded. ip_defrag selftest passed.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>

Applied, thanks Peter.
