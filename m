Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbfFEPOp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 5 Jun 2019 11:14:45 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 08/13] drivers: Add generic helper to match by name
Date: Wed,  5 Jun 2019 16:13:45 +0100
Message-Id: <1559747630-28065-9-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, suzuki.poulose@arm.com, Alessandro Zummo <a.zummo@towertech.it>, Alexander Aring <alex.aring@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Dan Murphy <dmurphy@ti.com>, Harald Freudenberger <freude@linux.ibm.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pavel Machek <pavel@ucw.cz>, Peter Oberparleiter <oberpar@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add a helper to match the device name

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-leds@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-wpan@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    | 6 ++++++
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 597095b..5724f93 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3352,3 +3352,9 @@ int device_match_acpi_dev(struct device *dev, const void *adev)
 	return ACPI_COMPANION(dev) == adev;
 }
 EXPORT_SYMBOL(device_match_acpi_dev);
+
+int device_match_name(struct device *dev, const void *name)
+{
+	return sysfs_streq(dev_name(dev), name);
+}
+EXPORT_SYMBOL_GPL(device_match_name);
diff --git a/include/linux/device.h b/include/linux/device.h
index a03b50d..74dd9c6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -167,6 +167,7 @@ int device_match_of_node(struct device *dev, const void *np);
 int device_match_fwnode(struct device *dev, const void *fwnode);
 int device_match_devt(struct device *dev, const void *pdevt);
 int device_match_acpi_dev(struct device *dev, const void *adev);
+int device_match_name(struct device *dev, const void *name);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-- 
2.7.4
