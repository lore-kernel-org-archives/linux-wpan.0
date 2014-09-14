Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53173 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbaINUvu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Sep 2014 16:51:50 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: PATCH IEEE 802.15.4: Add module parameter to mrf24j40 to allow use of external transmitters/receivers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5415F84C.9000401@componentsw.com>
Date: Sun, 14 Sep 2014 13:30:02 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <7155618F-72E7-4CFD-865F-86A9E1847095@holtmann.org>
References: <5415F84C.9000401@componentsw.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Walter Mack <wmack@componentsw.com>
Cc: linux-wpan@vger.kernel.org

Hi Walter,

> Add module parameter ext_rx_tx to support designs that use an external transmitter/receiver

this commit message is now missing all the details. That is not what I asked for. Start by reading Documentation/SubmittingPatches on what is expected.

> Signed-off-by: Walter J. Mack<wmack@componentsw.com>

you really need to address the review comments that I made on your previous submission. Just sending the same patch that has the same coding style issues and has not addressed all comments is a waste of everyone's time.

Regards

Marcel

