Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37592 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbaINXN7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Sep 2014 19:13:59 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so3077079wgg.30
        for <linux-wpan@vger.kernel.org>; Sun, 14 Sep 2014 16:13:58 -0700 (PDT)
Date: Mon, 15 Sep 2014 01:13:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: PATCH IEEE 802.15.4: Add module parameter to mrf24j40 to allow
 use of external transmitters/receivers
Message-ID: <20140914231350.GA5984@omega>
References: <5415F84C.9000401@componentsw.com>
 <7155618F-72E7-4CFD-865F-86A9E1847095@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7155618F-72E7-4CFD-865F-86A9E1847095@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Walter Mack <wmack@componentsw.com>, linux-wpan@vger.kernel.org, alan@signal11.us

Hi Marcel,

thanks for caring about this.

On Sun, Sep 14, 2014 at 01:30:02PM -0700, Marcel Holtmann wrote:
> Hi Walter,
> 
> > Add module parameter ext_rx_tx to support designs that use an external transmitter/receiver
> 
> this commit message is now missing all the details. That is not what I asked for. Start by reading Documentation/SubmittingPatches on what is expected.
> 
> > Signed-off-by: Walter J. Mack<wmack@componentsw.com>
> 
> you really need to address the review comments that I made on your previous submission. Just sending the same patch that has the same coding style issues and has not addressed all comments is a waste of everyone's time.
> 

Please also tag and base the patch for wpan-next.

Additional add the mrf24j40 maintainer alan@signal11.us to cc. After alan
ack alan it, I will apply this patch.

- Alex
