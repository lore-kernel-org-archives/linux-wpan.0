Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36502 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbDHKqf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 06:46:35 -0400
Received: by wizk4 with SMTP id k4so49909472wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 03:46:34 -0700 (PDT)
Date: Wed, 8 Apr 2015 12:46:31 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Raw ieee802154 socket
Message-ID: <20150408104630.GB1028@omega>
References: <5524ECA8.7000500@sssup.it>
 <20150408103017.GA1028@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150408103017.GA1028@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

On Wed, Apr 08, 2015 at 12:30:17PM +0200, Alexander Aring wrote:
...
> 2.
> The reason why you don't see the mac header is maybe because that [2]
> will skip the header. On a raw socket this should be recovered by a
> skb_push at [3] after share check, then we are sure that the skb is
> not shared anymore.

doh! The argument is wrong here, because skb_push doesn't manipulate the
buffer. :-) I just want to clarify this, you can still to that in this
place after the share_check.

- Alex
