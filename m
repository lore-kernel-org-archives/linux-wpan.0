Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:56128 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfB0US5 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 27 Feb 2019 15:18:57 -0500
Date: Wed, 27 Feb 2019 13:18:56 -0700
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/2] doc: net: ieee802154: move from plain text to rst
Message-ID: <20190227131856.2a9cfdde@lwn.net>
In-Reply-To: <20190227195914.4594-1-stefan@datenfreihafen.org>
References: <20190227195914.4594-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org

On Wed, 27 Feb 2019 20:59:12 +0100
Stefan Schmidt <stefan@datenfreihafen.org> wrote:

> The patches are based on net-next, but they only touch the networking book so I
> would not expect and trouble. From what I have seen they would go through
> Jonathan's tree after being acked by Dave? If you want this patches against a
> different tree let me know.

Usually Dave takes networking documentation patches directly, so that is
what I would expect here.

I took a quick look anyway; seems generally good.  The main comment I
would make is that much of what's there would be better placed as
kerneldoc comments in the code itself that can then be pulled into the
formatted docs.  But that can be a job for another day...

Thanks,

jon
