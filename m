Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbfFEQOn (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 5 Jun 2019 12:14:43 -0400
Date: Wed, 5 Jun 2019 18:14:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/13] drivers: Introduce variants of class_find_device()
Message-ID: <20190605161439.GB17272@kroah.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-11-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559747630-28065-11-git-send-email-suzuki.poulose@arm.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, rafael@kernel.org, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Dan Murphy <dmurphy@ti.com>, "David S. Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Harald Freudenberger <freude@linux.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jiri Slaby <jslaby@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pavel Machek <pavel@ucw.cz>, Peter Rosin <peda@axentia.se>, Stefan Schmidt <stefan@datenfreihafen.org>, Tomas Winkler <tomas.winkler@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Jun 05, 2019 at 04:13:47PM +0100, Suzuki K Poulose wrote:
> +/**
> + * class_find_device_by_devt : device iterator for locating a particular device
> + * matching the device type.
> + * @class: class type
> + * @start: device to start search from
> + * @devt: device type of the device to match.
> + */
> +static inline struct device *class_find_device_by_devt(struct class *class,
> +						       struct device *start,
> +						       dev_t devt)
> +{
> +	return class_find_device(class, start, &devt, device_match_devt);
> +}

Still has the start parameter, despite the changelog saying it would not
:(
