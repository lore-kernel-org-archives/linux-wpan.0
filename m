Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from picapica.im ([88.198.95.67]:60361 "EHLO picapica.im"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeCJR3e (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 10 Mar 2018 12:29:34 -0500
Date: Sat, 10 Mar 2018 18:29:32 +0100
From: anton@picapica.im
Subject: Re: "encryption failed" warnings in dmesg
Message-ID: <20180310172932.GA17439@picapica.im>
References: <20180307133525.GA30047@picapica.im>
 <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOHTApj8hq+Bqk0jsoqTvR=hPfsoZR6B3kn06+DanOb-7KZ18A@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

On Wed, Mar 07, 2018 at 10:43:09AM -0500, Alexander Aring wrote:

> 
> You need to use monitor interfaces to make it somehow working but be prepared:
> 
> 1. no hardware address filtering
> 2. no hardware ack handling
> 
> Have fun!
> 

Thank you for detailed answer, can you give more info about why monitor interface is
required?

Anton

